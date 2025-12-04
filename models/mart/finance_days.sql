with orders_margin as (
    select *
    from {{ ref('int_sales_margin') }}
),
orders_operational as (
    -- Sipariş başına operational_margin
    select *
    from {{ ref('int_orders_operational') }}
),

ship as (
    -- Nakliye/lojistik maliyetleri (order level)
    select *
    from {{ ref('stg_raw__ship') }}
)

select
    -- 1) Tarih
    o.date_date as date_date,

    -- 2) Toplam işlem sayısı (günlük sipariş adedi)
    count(distinct o.orders_id)                      as nb_transactions,

    -- 3) Toplam gelir
    sum(o.revenue)                                   as revenue,

    -- 4) Ortalama sepet (günlük toplam gelir / sipariş sayısı)
    sum(o.revenue) / count(distinct o.orders_id)     as avg_basket,

    -- 5) Toplam operasyonel marj (sipariş bazlı op. marjların toplamı)
    sum(op.operational_margin)                       as operational_margin,

    -- 6) Toplam satın alma maliyeti
    sum(o.purchase_cost)                             as purchase_cost,

    -- 7) Toplam nakliye ücretleri (müşteriden alınan)
    sum(s.shipping_fee)                              as shipping_fees,

    -- 8) Toplam lojistik maliyetler
    sum(s.log_cost)                                  as log_costs,

    -- 9) Satılan toplam ürün miktarı
    sum(o.quantity)                                  as quantity

from orders_margin o
left join orders_operational op
    on o.orders_id = op.orders_id
left join ship s
    on o.orders_id = s.orders_id
group by
    o.date_date