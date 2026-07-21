# ingestion/fetch_jolpica.py

import json
import requests
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, from_json

BASE_URL = "https://api.jolpi.ca/ergast/f1"
SEASONS = [2023, 2024]


def fetch_season_races(season: int) -> list[dict]:
    url = f"{BASE_URL}/{season}/races.json?limit=100"
    resp = requests.get(url)
    resp.raise_for_status()
    return resp.json()["MRData"]["RaceTable"]["Races"]


def fetch_season_drivers(season: int) -> list[dict]:
    url = f"{BASE_URL}/{season}/drivers.json?limit=100"
    resp = requests.get(url)
    resp.raise_for_status()
    return resp.json()["MRData"]["DriverTable"]["Drivers"]


def fetch_season_constructors(season: int) -> list[dict]:
    url = f"{BASE_URL}/{season}/constructors.json?limit=100"
    resp = requests.get(url)
    resp.raise_for_status()
    return resp.json()["MRData"]["ConstructorTable"]["Constructors"]


def fetch_race_results(season: int, round_num: int) -> list[dict]:
    url = f"{BASE_URL}/{season}/{round_num}/results.json?limit=100"
    resp = requests.get(url)
    resp.raise_for_status()
    races = resp.json()["MRData"]["RaceTable"]["Races"]
    if not races:
        return []
    # results are nested one level under the race
    race = races[0]
    results = race["Results"]
    for r in results:
        r["season"] = season
        r["round"] = round_num
        r["raceName"] = race["raceName"]
    return results


def write_bronze(records: list[dict], table_name: str, spark: SparkSession):
    json_strings = [json.dumps(r) for r in records]
    df_strings = spark.createDataFrame([(s,) for s in json_strings], ["json_str"])
    schema = df_strings.selectExpr("schema_of_json_agg(json_str)").collect()[0][0]
    df = df_strings.select(from_json(col("json_str"), schema).alias("parsed")).select("parsed.*")
    df.write.format("delta").mode("overwrite").saveAsTable(table_name)
    print(f"Written {df.count()} rows to {table_name}")


def main():
    spark = SparkSession.builder.getOrCreate()

    # Races
    all_races = []
    for season in SEASONS:
        races = fetch_season_races(season)
        all_races.extend(races)
    write_bronze(all_races, "f1_project.bronze.races_raw", spark)

    # Drivers
    all_drivers = []
    for season in SEASONS:
        drivers = fetch_season_drivers(season)
        for d in drivers:
            d["season"] = season
        all_drivers.extend(drivers)
    write_bronze(all_drivers, "f1_project.bronze.drivers_raw", spark)

    # Constructors
    all_constructors = []
    for season in SEASONS:
        constructors = fetch_season_constructors(season)
        for c in constructors:
            c["season"] = season
        all_constructors.extend(constructors)
    write_bronze(all_constructors, "f1_project.bronze.constructors_raw", spark)

    # Race results (round-by-round, per season)
    all_results = []
    for season in SEASONS:
        num_rounds = len(fetch_season_races(season))
        for round_num in range(1, num_rounds + 1):
            results = fetch_race_results(season, round_num)
            all_results.extend(results)
            print(f"Season {season} Round {round_num}: {len(results)} results fetched")
    write_bronze(all_results, "f1_project.bronze.results_raw", spark)


if __name__ == "__main__":
    main()