-- models/mart/finance_days.sql

with orders_margin as (
    select *
    from {{ ref('int_sales_margin') }}
),

orders_operational as (
    select *
    from {{ ref('int_orders_operational') }}
),

ship as (
    select *
    from {{ ref('stg_raw__ship') }}
)

select
    o.date_date,
    count(distinct o.orders_id)                  as nb_transactions,
    sum(o.revenue)                               as revenue,
    sum(o.revenue) / count(distinct o.orders_id) as avg_basket,
    sum(o.margin)                                as margin,
    sum(op.operational_margin)                   as operational_margin,
    sum(o.purchase_cost)                         as purchase_cost,
    sum(s.shipping_fee)                          as shipping_fees,
    sum(s.log_cost)                              as log_costs,
    sum(s.ship_cost)                             as ship_cost,
    sum(o.quantity)                              as quantity
from orders_margin o
left join orders_operational op using (orders_id)
left join ship s using (orders_id)
group by o.date_date
order by o.date_date desc