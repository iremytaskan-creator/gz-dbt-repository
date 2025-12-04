with sales as (
    select *
    from {{ ref('stg_raw__sales') }}
),

product as (
    select *
    from {{ ref('stg_raw__product') }}
)

select
    s.orders_id,
    s.date_date,
    s.product_id,
    s.quantity,
    p.purchase_price,
    s.revenue,
    s.quantity * p.purchase_price                   as purchase_cost,
    s.revenue - (s.quantity * p.purchase_price)     as margin
from sales s
left join product p
    on s.product_id = p.product_id
