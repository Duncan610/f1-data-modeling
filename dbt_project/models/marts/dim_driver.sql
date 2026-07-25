SELECT
    driver_id,
    driver_code,
    given_name,
    family_name,
    date_of_birth,
    nationality,
    permanent_number,
    driver_url
FROM {{ ref('stg_drivers') }}