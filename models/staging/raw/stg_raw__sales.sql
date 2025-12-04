with source as (

    select
        date_date,
        orders_id,
        pdt_id      as product_id,
        revenue,
        quantity
    from {{ source('raw', 'sales') }}

)

select
    date_date,
    orders_id,
    product_id,
    cast(revenue  as numeric) as revenue,
    cast(quantity as int64)   as quantity
from source
