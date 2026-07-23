
  
  
  
  create or replace view `f1_project`.`silver`.`stg_drivers`
  
  as (
    WITH deduped AS(
    SELECT
        code AS driver_code,
        driverId AS driver_id,
        familyName AS family_name,
        givenName AS given_name,
        nationality,
        season,
        url AS driver_url,
        CAST(dateofBirth AS DATE) AS date_of_birth,
        CAST(permanentNumber AS int) AS permanent_number,
        ROW_NUMBER() OVER(PARTITION BY driverId ORDER BY season DESC) AS rn
    FROM `f1_project`.`bronze`.`drivers_raw`
)
SELECT 
    driver_id,
    driver_code,
    given_name,
    family_name,
    date_of_birth,
    nationality,
    permanent_number,
    driver_url
FROM deduped
WHERE rn = 1
  )
