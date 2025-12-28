--Running Monthly Orders per City

SELECT
    city,
    DATE_TRUNC('month', order_date) AS month,
    COUNT(*) AS monthly_orders,
    SUM(COUNT(*)) OVER (
        PARTITION BY city
        ORDER BY DATE_TRUNC('month', order_date)
    ) AS running_orders
FROM orders
GROUP BY city, month
ORDER BY city, month;

--SLA Breach Ranking by Month (Top Delay Cities)

WITH city_delays AS (
    SELECT
        city,
        DATE_TRUNC('month', order_date) AS month,
        COUNT(*) FILTER (WHERE status = 'Delayed') AS delayed_orders
    FROM orders
    GROUP BY city, month
)
SELECT
    city,
    month,
    delayed_orders,
    RANK() OVER (
        PARTITION BY month
        ORDER BY delayed_orders DESC
    ) AS delay_rank
FROM city_delays;

--Top 1 Delay Agent per Month

WITH agent_delays AS (
    SELECT
        agent_id,
        DATE_TRUNC('month', order_date) AS month,
        COUNT(*) AS delay_count
    FROM orders
    WHERE status = 'Delayed'
    GROUP BY agent_id, month
),
ranked_agents AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY month
               ORDER BY delay_count DESC
           ) AS rn
    FROM agent_delays
)
SELECT
    month,
    agent_id,
    delay_count
FROM ranked_agents
WHERE rn = 1;

--Delivery TAT Comparison vs City Average

SELECT
    order_id,
    city,
    (delivery_date - order_date) AS order_tat,
    AVG(delivery_date - order_date) OVER (
        PARTITION BY city
    ) AS city_avg_tat
FROM orders;

--Latest Order per Agent (Dedup Pattern)

WITH ranked_orders AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY agent_id
            ORDER BY order_date DESC
        ) AS rn
    FROM orders
)
SELECT *
FROM ranked_orders
WHERE rn = 1;
