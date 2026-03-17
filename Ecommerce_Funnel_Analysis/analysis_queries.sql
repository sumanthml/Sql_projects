-- =================================================================
-- PROJECT: E-Commerce Funnel & Attribution Analysis
-- PURPOSE: End-to-End Business Intelligence Queries
-- =================================================================

-- 1. THE CONVERSION FUNNEL (With Step-by-Step Retention %)
-- This query identifies where users are dropping off in the journey.
WITH Funnel AS (
    SELECT 
        event_type,
        COUNT(DISTINCT user_id) as user_count
    FROM Sessions
    GROUP BY event_type
)
SELECT 
    event_type,
    user_count,
    ROUND(100.0 * user_count / (SELECT MAX(user_count) FROM Funnel), 2) as pct_of_total_traffic,
    ROUND(100.0 * user_count / LAG(user_count) OVER (ORDER BY user_count DESC), 2) as retention_from_prev_step
FROM Funnel
ORDER BY user_count DESC;


-- 2. MARKETING CHANNEL ATTRIBUTION (ROI Analysis)
-- Calculates which channel (Google, FB, etc.) brings the most revenue.
SELECT 
    u.source_channel,
    COUNT(o.order_id) as total_orders,
    SUM(o.order_amount) as total_revenue,
    ROUND(AVG(o.order_amount), 2) as avg_order_value
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
GROUP BY u.source_channel
ORDER BY total_revenue DESC;


-- 3. PURCHASE VELOCITY (Time-to-Buy)
-- Measures how many minutes it takes for a user to convert after landing.
SELECT 
    s1.user_id,
    (strftime('%s', s2.event_timestamp) - strftime('%s', s1.event_timestamp)) / 60 as minutes_to_convert
FROM Sessions s1
JOIN Sessions s2 ON s1.user_id = s2.user_id
WHERE s1.event_type = 'page_view' 
  AND s2.event_type = 'purchase'
ORDER BY minutes_to_convert ASC;


-- 4. GEOGRAPHIC REVENUE DISTRIBUTION
-- Identifies top-performing countries.
SELECT 
    u.country,
    COUNT(DISTINCT u.user_id) as total_users,
    SUM(o.order_amount) as revenue
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.user_id
GROUP BY u.country
ORDER BY revenue DESC;