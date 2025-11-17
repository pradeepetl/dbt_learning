select *
from {{ ref('stg_sales') }}
where round(profit / nullif(sales, 0), 2) != margin