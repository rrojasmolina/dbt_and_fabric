{% macro grant_select(role, schema=target.schema)%}
    {% set sql %}
        grant select on schema::{{ schema }} to {{ role }};
    {% endset %}
    {{ log('Granting select on all tables and views in schema ' ~ target.schema ~ ' to role ' ~ role, info=True) }}
    {% do run_query(sql) %}
    {{ log('Privileges granted', info=True) }}
{% endmacro %}