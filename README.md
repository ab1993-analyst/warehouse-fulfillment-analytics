# Warehouse Fulfillment Analytics

## Overview

This project simulates a large-scale warehouse fulfillment operation and analyzes operational quality using Python, SQL, Google BigQuery, and Tableau.

The dataset contains more than **1 million simulated warehouse orders** covering an entire year of operations.

---

## Business Problem

Warehouse operations generate millions of orders each year. Quality issues such as damaged products, incorrect picks, and missed inspections increase costs and reduce customer satisfaction.

This project identifies operational risks by analyzing:

- Defect rates
- Pick station performance
- Pack station performance
- Shift quality
- Monthly trends
- High-risk workflows

---

## Tools

- Python
- Pandas
- Google BigQuery
- SQL
- Tableau
- GitHub

---

## Dataset

The Python script generates:

- 1M+ warehouse orders
- Pick stations
- Pack stations
- Product categories
- Shifts
- Processing timestamps
- Robot inspections
- Defect classifications

---

## Project Workflow

```
Python
      ↓
Generate Dataset
      ↓
CSV
      ↓
Google BigQuery
      ↓
SQL Analytics
      ↓
Views
      ↓
Tableau Dashboard
```

---

## Key KPIs

- Total Orders
- Overall Defect Rate
- Monthly Defect Rate
- Shift Performance
- Pick Station Quality
- Pack Station Quality
- High-Risk Workflow Detection
- Station Productivity

---

## SQL Analysis

Example analyses include:

- Overall defect rate
- Monthly trends
- Worst-performing pick stations
- Worst-performing pack stations
- Shift comparison
- Executive summary
- High-risk workflow analysis

---

## Dashboard

The Tableau dashboard includes:

- Executive KPI cards
- Monthly defect trend
- Shift heatmap
- Pick station performance
- Pack station performance
- High-risk workflows

---

## Repository Structure

```
data/
python/
sql/
tableau/
images/
README.md
```

---

## Skills Demonstrated

- Python
- Data Generation
- SQL
- BigQuery
- Tableau
- Data Visualization
- Business Intelligence
- KPI Development
- Root Cause Analysis
