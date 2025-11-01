{% macro calculate_profit_and_margin(sales_col, cost_col) %}
    (
        {{ sales_col }} - {{ cost_col }}
    ) as profit,
    case when {{ sales_col }} > 0
         then round(({{ sales_col }} - {{ cost_col }}) / {{ sales_col }}, 2)
         else 0 end as margin
{% endmacro %}
