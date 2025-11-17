select
    region,
    category,
    sum(sales) as total_sales,
    sum(cost) as total_cost,
    sum(profit) as total_profit,
    avg(margin) as avg_margin
from (
    --- What if we need to use this subquery in multiple models?
    --- we can't repeat the same logic everywhere
    select
        region,
        category,
        order_id,
        order_date,
        sales_amount as sales,
        cost_amount as cost,
        (sales_amount - cost_amount) as profit, -- profit calculation
        case when sales_amount > 0
             then round((sales_amount - cost_amount) / sales_amount, 2) -- margin calculation
             else 0 end as margin
    from sales_raw  -- what if this table is used in multiple models?
    where order_date >= '2024-01-01'
) base
where profit > 0
group by region, category
order by total_profit desc;
