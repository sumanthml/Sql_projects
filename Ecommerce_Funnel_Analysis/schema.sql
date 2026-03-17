-- ==========================================================
-- PROJECT: E-Commerce Funnel & Attribution System
-- FILE: schema.sql
-- ==========================================================

-- 1. Create Tables
CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY,
    signup_date DATE,
    country VARCHAR(50),
    source_channel VARCHAR(20) 
);

CREATE TABLE Sessions (
    session_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    event_type VARCHAR(20), -- 'page_view', 'add_to_cart', 'purchase'
    event_timestamp TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    order_amount DECIMAL(10, 2),
    order_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 2. Insert Deep Mock Data for Testing
INSERT INTO Users VALUES 
(1, '2026-03-01', 'India', 'Google'), (2, '2026-03-01', 'USA', 'Facebook'),
(3, '2026-03-02', 'India', 'Organic'), (4, '2026-03-02', 'UK', 'Google'),
(5, '2026-03-03', 'India', 'Direct'),  (6, '2026-03-03', 'USA', 'Facebook');

INSERT INTO Sessions VALUES 
(101, 1, 'page_view', '2026-03-01 10:00:00'), (102, 1, 'add_to_cart', '2026-03-01 10:05:00'), (103, 1, 'purchase', '2026-03-01 10:10:00'),
(104, 2, 'page_view', '2026-03-01 11:00:00'), (105, 2, 'add_to_cart', '2026-03-01 11:05:00'),
(106, 3, 'page_view', '2026-03-02 12:00:00'), 
(107, 4, 'page_view', '2026-03-02 13:00:00'), (108, 4, 'add_to_cart', '2026-03-02 13:05:00'), (109, 4, 'purchase', '2026-03-02 13:10:00'),
(110, 5, 'page_view', '2026-03-03 09:00:00'), (111, 6, 'page_view', '2026-03-03 10:00:00');

INSERT INTO Orders VALUES 
(501, 1, 1500.00, '2026-03-01'),
(502, 4, 2200.00, '2026-03-02');