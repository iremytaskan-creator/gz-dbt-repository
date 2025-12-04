{{ config(
    materialized='table'
) }}

with source_sales as (
    select *
    from {{ source('raw', 'sales') }}
),

daily_metrics as (
    select
        date_date as order_date,
        count(orders_id) as daily_order_count,
        avg(revenue) as avg_basket,
        sum(revenue) as daily_margin,
        sum(revenue) as daily_operational_margin
    from source_sales
    group by 1
)

select *
from daily_metrics
order by order_date
