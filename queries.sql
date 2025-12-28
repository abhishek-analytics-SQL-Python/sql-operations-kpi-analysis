-- Average delivery TAT by city
SELECT 
    city,
    AVG(delivery_date - order_date) AS avg_tat_days
FROM orders
GROUP BY city;

-- SLA breach percentage per month
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    COUNT(*) FILTER (WHERE status = 'Delayed') * 100.0 / COUNT(*) AS sla_breach_pct
FROM orders
GROUP BY month
ORDER BY month;

-- Top delayed agents
WITH delays AS (
    SELECT 
        agent_id,
        COUNT(*) AS delayed_orders
    FROM orders
    WHERE status = 'Delayed'
    GROUP BY agent_id
)
SELECT 
    a.agent_name,
    d.delayed_orders
FROM delays d
JOIN agents a ON d.agent_id = a.agent_id
ORDER BY d.delayed_orders DESC;
