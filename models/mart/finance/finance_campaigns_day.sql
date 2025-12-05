-- models/mart/finance/finance_campaigns_day.sql
-- Gün bazında finans + reklam metriklerini birleştirir

with campaigns as (
    select
        date_date,
        ads_cost,
        ads_impression,
        ads_clicks
    from {{ ref('int_campaigns_day') }}
),

finance as (
    select
        date_date,
        avg_basket,
        operational_margin,
        purchase_cost,
        shipping_fees,
        log_costs,
        ship_cost,
        quantity,
        revenue,
        margin
    from {{ ref('finance_days') }}
)

select
    f.date_date                               as date,
    coalesce(f.operational_margin, 0) - coalesce(c.ads_cost, 0) as ads_margin,
    f.avg_basket                              as average_basket,
    coalesce(f.operational_margin, 0)         as operational_margin,
    coalesce(c.ads_cost, 0)                   as ads_cost,
    coalesce(c.ads_impression, 0)             as ads_impression,
    coalesce(c.ads_clicks, 0)                 as ads_clicks,
    f.quantity,
    f.revenue,
    f.purchase_cost,
    f.margin,
    f.shipping_fees                           as shipping_fee,
    f.log_costs                               as log_cost,
    f.ship_cost
from finance f
left join campaigns c
    on f.date_date = c.date_date
order by date desc