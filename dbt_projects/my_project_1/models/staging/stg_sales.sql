-- models/staging/stg_sales.sql
SELECT
  region,
  category,
  order_id,
  order_date,
  sales_amount AS sales,
  cost_amount AS cost,
  {{ calculate_profit_and_margin('sales_amount', 'cost_amount') }}
FROM {{ source('public', 'sales_raw') }}
WHERE order_date >= '2024-01-01'
