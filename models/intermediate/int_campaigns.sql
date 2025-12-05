-- models/intermediate/int_campaigns.sql

with adwords as (
    select
        date_date,
        paid_source,
        campaign_key,
        campaign_name,
        ads_cost,
        impression,
        click
    from {{ ref('stg_raw__adwords') }}
),

bing as (
    select
        date_date,
        paid_source,
        campaign_key,
        campaign_name,
        ads_cost,
        impression,
        click
    from {{ ref('stg_raw__bing') }}
),

criteo as (
    select
        date_date,
        paid_source,
        campaign_key,
        campaign_name,
        ads_cost,
        impression,
        click
    from {{ ref('stg_raw__criteo') }}
),

facebook as (
    select
        date_date,
        paid_source,
        campaign_key,
        campaign_name,
        ads_cost,
        impression,
        click
    from {{ ref('stg_raw__facebook') }}
)

select
    date_date,
    paid_source,
    campaign_key,
    campaign_name,
    ads_cost,
    impression,
    click
from adwords

union all

select
    date_date,
    paid_source,
    campaign_key,
    campaign_name,
    ads_cost,
    impression,
    click
from bing

union all

select
    date_date,
    paid_source,
    campaign_key,
    campaign_name,
    ads_cost,
    impression,
    click
from criteo

union all

select
    date_date,
    paid_source,
    campaign_key,
    campaign_name,
    ads_cost,
    impression,
    click
from facebook