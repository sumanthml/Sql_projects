# 🛒 E-Commerce Multi-Channel Attribution & Funnel Analysis

![SQL](https://img.shields.io/badge/Language-SQL-blue?style=for-the-badge&logo=postgresql)
![Database](https://img.shields.io/badge/Engine-SQLite_/_PostgreSQL-lightgrey?style=for-the-badge&logo=sqlite)
![Analytics](https://img.shields.io/badge/Focus-Business_Intelligence-orange?style=for-the-badge&logo=tableau)

## 📌 Project Overview
This project focuses on **Customer Journey Mapping** and **Conversion Rate Optimization (CRO)** for a digital retail platform. By analyzing millions of session-level events, this system identifies friction points in the sales funnel and quantifies the ROI of various marketing acquisition channels.

### ⚠️ The Business Problem
In a competitive e-commerce landscape, businesses need to know:
1. **Where are we losing customers?** (The Drop-off Point)
2. **Which ads are actually making money?** (Attribution)
3. **How long does a customer hesitate before buying?** (Conversion Velocity)

---

## 🚀 Key Analysis Features

### 1. 3-Stage Conversion Funnel
Using **Common Table Expressions (CTEs)** and **Window Functions**, the system tracks users through:
* `Page View` → `Add to Cart` → `Purchase`
* Calculates **Retention %** from the previous step to identify UI/UX bottlenecks.

### 2. Marketing Attribution Model
A multi-table join between `Users` and `Orders` to calculate:
* **Total Revenue** per channel (Google, Facebook, Organic, etc.)
* **Average Order Value (AOV)** to identify high-quality traffic sources.

### 3. Purchase Velocity Metrics
Implemented using **Self-Joins** and time-difference logic to measure the time elapsed from a user's first interaction to their final transaction.

---

## 🛠 Database Schema


* **Users Table:** Stores demographic and acquisition source data.
* **Sessions Table:** Atomic-level event tracking (Behavioral data).
* **Orders Table:** Transactional records linked to specific users and sessions.

---

## 📈 Example Insights Generated
| Step | User Count | Retention % |
| :--- | :--- | :--- |
| **Page View** | 5,000 | 100% |
| **Add to Cart** | 3,000 | 60% |
| **Purchase** | 2,000 | 66% (of cart) |

**Conclusion:** The biggest drop-off (40%) happens between 'View' and 'Cart', suggesting the product pricing or landing page clarity needs improvement.

---

## 📂 Project Structure
```text
├── schema.sql             # Table definitions & Deep Mock Data
├── analysis_queries.sql   # Advanced BI & Window Function queries
└── README.md              # Project documentation
