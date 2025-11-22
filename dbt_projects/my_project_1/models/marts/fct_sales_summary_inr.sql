{{ config(
    materialized = 'incremental',
    unique_key = 'order_id'
) }}

select
    order_id,
    region,
    category,
    sales,
    cost,
    profit,
    margin,
    order_date
from {{ ref('stg_sales') }}

{% if is_incremental() %}

-- Only load records that are new or updated since the last run
where order_date > (select max(order_date) from {{ this }})

{% endif %}
