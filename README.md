# SQL Operations KPI & SLA Analysis

This project demonstrates how SQL can be used to analyze
operational performance, SLA adherence, and agent efficiency
using real-world analytics patterns.

## Business Objective
Operations leaders need visibility into:
- SLA breaches
- Turnaround Time (TAT)
- City and agent-level performance
- Monthly operational trends

## Dataset
Simulated operations data:
- Orders with delivery timelines
- Agents handling deliveries
- City-level operations

## SQL Concepts Demonstrated
- Complex JOINs
- Common Table Expressions (CTEs)
- Window functions (ROW_NUMBER, RANK, running totals)
- Top-N per group analysis
- Deduplication logic
- Date-based trend analysis

## Key Insights Generated
- Identified cities and agents driving SLA breaches
- Ranked delay contributors month-over-month
- Compared individual delivery TAT against city averages
- Tracked operational trends using running aggregates

## Tools
- PostgreSQL-compatible SQL

## Use Case Relevance
Applicable to Operations Analytics, Business Analytics,
Risk Monitoring, and Process Optimization roles.
