SELECT
    cast(season AS int) AS season,
    cast(round AS int) AS round,
    raceName as race_name,
    date as race_date,
    Circuit.circuitId as circuit_id,
    Circuit.circuitName as circuit_name,
    Circuit.url as circuit_url,
    Circuit.Location.locality as circuit_locality,
    Circuit.Location.country as circuit_country,
    cast(Circuit.Location.lat as double) as circuit_lat,
    cast(Circuit.Location.long as double) as circuit_long,
    to_timestamp(concat(FirstPractice.date, 'T', FirstPractice.time)) as first_practice,
    to_timestamp(concat(SecondPractice.date, 'T', SecondPractice.time)) as second_practice,
    to_timestamp(concat(ThirdPractice.date, 'T', ThirdPractice.time)) as third_practice,
    to_timestamp(concat(Qualifying.date, 'T', Qualifying.time)) as qualifying,
    to_timestamp(concat(Sprint.date, 'T', Sprint.time)) as sprint,
    to_timestamp(concat(SprintQualifying.date, 'T', SprintQualifying.time)) as sprint_qualifying,
    to_timestamp(concat(SprintShootout.date, 'T', SprintShootout.time)) as sprint_shootout,
    url as race_url

FROM {{ source('bronze', 'races_raw') }}