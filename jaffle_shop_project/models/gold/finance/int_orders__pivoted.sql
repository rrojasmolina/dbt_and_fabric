{%- set payment_methods_sql -%}
    select distinct payment_method from {{ ref('stg__payments') }}
{%- endset -%}
{%- if execute -%}
    {%- set results = run_query(payment_methods_sql) -%}
    {%- if results is not none and results.columns[0].values()|length > 0 -%}
        {%- set payment_methods = results.columns[0].values() -%}
    {%- else -%}
        {%- set payment_methods = ['dummy'] -%}
    {%- endif -%}
{%- endif -%}

with payments as 
(
    select * from {{ ref('stg__payments') }}
    where status = 'success'
),
pivoted as 
(
     select order_id,
    {%- for method in payment_methods -%}
        cast(sum(case when payment_method =  '{{ method }}' then amount else 0 end) as decimal(18,2)) as {{ method }}_amount
        {%- if not loop.last -%}
            , 
        {% endif %}
    {% endfor %}    
     from payments
     group by order_id
)
select * from pivoted