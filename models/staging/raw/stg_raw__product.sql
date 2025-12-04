with source as (

    select
        products_id,
        purchSE_PRICE
    from {{ source('raw', 'product') }}

)

select
    products_id as product_id,
    safe_cast(replace(purchSE_PRICE, ',', '.') as numeric) as purchase_price
from source
