with source as (

    select
        orders_id,
        shipping_fee,
        logCost,
        ship_cost_num
    from {{ source('raw', 'ship') }}   -- schema.yml'deki name: raw / name: ship

)

select
    orders_id,
    cast(shipping_fee as numeric) as shipping_fee,
    cast(logCost      as numeric) as log_cost,
    ship_cost_num                  as ship_cost
from source