select  
    customer_id,
    order_date,
    {{ dbt_utils.generate_surrogate_key(['customer_id', 'order_date']) }} as pk,
    count(*) as co
from {{ ref('stg__orders')}}
group by customer_id, order_date