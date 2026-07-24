{% macro parse_timedelta_ms(column_name) %}
    case
        when {{ column_name }} is null or {{ column_name }} in ('NaT', '-', '') then null
        else
            try_cast(regexp_extract({{ column_name }}, '^(\\d+) days', 1) as bigint) * 86400000
            + try_cast(regexp_extract({{ column_name }}, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 1) as bigint) * 3600000
            + try_cast(regexp_extract({{ column_name }}, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 2) as bigint) * 60000
            + try_cast(regexp_extract({{ column_name }}, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 3) as bigint) * 1000
            + try_cast(regexp_extract({{ column_name }}, '(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{6})$', 4) as bigint) / 1000
    end
{% endmacro %}