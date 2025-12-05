
with base as (
    select
        date_date,
        ads_cost,
        impression as ads_impression,
        click       as ads_clicks
    from {{ ref('int_campaigns') }}
),

aggregated as (
    select
        date_date,
        sum(ads_cost)        as ads_cost,
        sum(ads_impression)  as ads_impression,
        sum(ads_clicks)      as ads_clicks
    from base
    group by date_date
)

select *
from aggregated
order by date_date desc

