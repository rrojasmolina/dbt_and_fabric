select  
    customer_id,
    order_date,
    count(*) as customers_count
from {{ ref('stg__orders')}}
group by customer_id, order_date