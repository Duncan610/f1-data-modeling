SELECT
    constructor_id,
    constructor_name,
    nationality,
    constructor_url
FROM {{ ref('stg_constructors') }}