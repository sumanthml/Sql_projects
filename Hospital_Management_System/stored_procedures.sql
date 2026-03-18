-- ==========================================================
-- PROJECT: Hospital Analytics Logic
-- FILE: stored_procedures.sql
-- ==========================================================

-- A. CREATE A VIRTUAL VIEW FOR DOCTOR PERFORMANCE
-- This summarizes all doctor stats without running complex joins every time.
CREATE VIEW Doctor_Performance_Summary AS
SELECT 
    d.doctor_id,
    d.name AS doctor_name,
    dept.dept_name,
    COUNT(a.app_id) AS total_patients_treated,
    SUM(a.fee) AS revenue_generated,
    AVG(a.fee) AS avg_consultation_fee
FROM Doctors d
JOIN Departments dept ON d.dept_id = dept.dept_id
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
WHERE a.status = 'Completed'
GROUP BY d.doctor_id;

-- B. COMPLEX QUERY: Identifying "High-Value" At-Risk Patients
-- Finds elderly patients (> 60) who have spent more than the average hospital bill.
WITH AvgBill AS (
    SELECT AVG(fee) as global_avg FROM Appointments
)
SELECT 
    p.name, 
    p.age, 
    p.insurance_provider,
    SUM(a.fee) as total_spent
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
WHERE p.age > 60
GROUP BY p.patient_id
HAVING total_spent > (SELECT global_avg FROM AvgBill);

-- C. DEPARTMENTAL UTILIZATION REPORT
-- Shows which department is the busiest and most profitable.
SELECT 
    dept.dept_name,
    COUNT(DISTINCT d.doctor_id) as staff_count,
    COUNT(a.app_id) as total_appointments,
    SUM(a.fee) as dept_revenue,
    RANK() OVER (ORDER BY SUM(a.fee) DESC) as revenue_rank
FROM Departments dept
JOIN Doctors d ON dept.dept_id = d.dept_id
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY dept.dept_id;

-- D. APPOINTMENT TREND ANALYSIS (Self-Join)
-- Checks if a patient had a follow-up within 7 days.
SELECT 
    p.name,
    a1.app_date as initial_visit,
    a2.app_date as follow_up_visit,
    (strftime('%s', a2.app_date) - strftime('%s', a1.app_date)) / 86400 as days_between
FROM Appointments a1
JOIN Appointments a2 ON a1.patient_id = a2.patient_id
JOIN Patients p ON a1.patient_id = p.patient_id
WHERE a1.app_id < a2.app_id 
AND days_between <= 7;