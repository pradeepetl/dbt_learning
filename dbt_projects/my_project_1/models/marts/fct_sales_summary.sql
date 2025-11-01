-- models/marts/fct_sales_summary.sql
SELECT
  region,
  category,
  SUM(profit) AS total_profit,
  SUM(sales) AS total_sales,
  SUM(cost) AS total_cost,
  AVG(margin) AS avg_margin
FROM {{ ref('stg_sales') }}
WHERE profit > 0
GROUP BY region, category
ORDER BY total_profit DESC
