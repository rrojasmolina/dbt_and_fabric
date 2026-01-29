select
        ID as order_id,
        USER_ID as customer_id,
        ORDER_DATE as order_date,
        STATUS as status,
        _elt_load_date
    from {{source('jaffle_shop', 'orders')}}
