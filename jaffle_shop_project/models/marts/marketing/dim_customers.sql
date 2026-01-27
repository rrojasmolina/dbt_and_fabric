with customers as (

    select * from {{ ref('stg__customers') }}

),

orders as (

    select * from {{ ref('fct_orders') }}
),
customer_orders as (

    select
        o.customer_id,
        min(o.order_date) as first_order_date,
        max(o.order_date) as most_recent_order_date,
        count(o.order_id) as number_of_orders,
        sum(o.amount) as lifetime_value
    from orders o
    group by o.customer_id

),
final as (

    select
        c.customer_id,
        c.first_name,
        c.last_name,
        co.first_order_date,
        co.most_recent_order_date,
        coalesce(co.number_of_orders, 0) as number_of_orders,
        coalesce(co.lifetime_value, 0) as lifetime_value
    from customers c
    left join customer_orders co on co.customer_id = c.customer_id

)

select * from final