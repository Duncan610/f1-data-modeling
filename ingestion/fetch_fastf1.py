# /// script
# [tool.databricks.environment]
# environment_version = "5"
# dependencies = [
#   "fastf1",
# ]
# ///
# ingestion of fastf1

import os
import fastf1
from pyspark.sql import SparkSession

CACHE_PATH = "/local_disk0/tmp/fastf1_cache"
os.makedirs(CACHE_PATH, exist_ok=True)
fastf1.Cache.enable_cache(CACHE_PATH)

SEASON_ROUNDS = {
    2023: 22,
    2024: 24,
}


def fetch_race_laps_and_pits(season: int, round_num: int):
    session = fastf1.get_session(season, round_num, "R", backend="ergast")
    session.load(laps=True, telemetry=False, weather=False)

    laps_df = session.laps.copy()
    laps_df["season"] = season
    laps_df["round"] = round_num

    # Pit stops: laps where PitInTime or PitOutTime is not null
    pit_df = laps_df[laps_df["PitInTime"].notna() | laps_df["PitOutTime"].notna()].copy()

    return laps_df, pit_df


def main():
    spark = SparkSession.builder.getOrCreate()

    all_laps = []
    all_pits = []

    for season, num_rounds in SEASON_ROUNDS.items():
        for round_num in range(1, num_rounds + 1):
            try:
                laps_df, pit_df = fetch_race_laps_and_pits(season, round_num)
                all_laps.append(laps_df)
                all_pits.append(pit_df)
                print(f"Season {season} Round {round_num}: {len(laps_df)} laps, {len(pit_df)} pit events")
            except Exception as e:
                print(f"FAILED Season {season} Round {round_num}: {e}")

    import pandas as pd
    laps_pd = pd.concat(all_laps, ignore_index=True)
    pits_pd = pd.concat(all_pits, ignore_index=True)

    # Convert timedelta columns to strings (Spark doesn't handle pandas Timedelta natively)
    for col in laps_pd.select_dtypes(include=["timedelta64[ns]"]).columns:
        laps_pd[col] = laps_pd[col].astype(str)
    for col in pits_pd.select_dtypes(include=["timedelta64[ns]"]).columns:
        pits_pd[col] = pits_pd[col].astype(str)

    laps_df_spark = spark.createDataFrame(laps_pd)
    pits_df_spark = spark.createDataFrame(pits_pd)

    laps_df_spark.write.format("delta").mode("overwrite").saveAsTable("f1_project.bronze.laps_raw")
    pits_df_spark.write.format("delta").mode("overwrite").saveAsTable("f1_project.bronze.pit_stops_raw")

    print(f"Written {laps_df_spark.count()} rows to f1_project.bronze.laps_raw")
    print(f"Written {pits_df_spark.count()} rows to f1_project.bronze.pit_stops_raw")


if __name__ == "__main__":
    main()