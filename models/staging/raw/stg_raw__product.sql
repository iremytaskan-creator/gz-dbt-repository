with source as (
    select * from {{ source('raw', 'product') }}
),
renamed as (
    select
        -- BURASI KRİTİK: products_id'yi product_id yapıyoruz
        products_id AS product_id,
        
        CAST(REPLACE(purchSE_PRICE, ',', '.') AS FLOAT64) AS purchase_price
    from source
)
select * from renamed