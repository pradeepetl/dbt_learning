{% snapshot sales_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='order_id',
        strategy='timestamp',
        updated_at='order_date'
    )
}}

SELECT
    order_id,
    region,
    category,
    sales_amount,
    cost_amount,
    (sales_amount - cost_amount) AS profit,
    CASE 
        WHEN sales_amount > 0 THEN ROUND((sales_amount - cost_amount)/sales_amount, 2)
        ELSE 0 
    END AS margin,
    order_date
FROM {{ source('public', 'sales_raw') }}

{% endsnapshot %}