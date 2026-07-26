import subprocess

result = subprocess.run(
    ["dbt", "run", "--select", "stg_races", "stg_drivers", "stg_constructors", "stg_results", "stg_laps", "stg_pit_stops", "dim_driver", "dim_circuit", "dim_constructor", "dim_race", "dim_driver_constructor", "fact_race_results", "fact_pit_stops",
     "--project-dir", "/Workspace/f1_project/f1-data-modeling/dbt_project",
     "--profiles-dir", "/Workspace/f1_project/f1-data-modeling/dbt_project"],
    capture_output=True, text=True
)
print(result.stdout)
print(result.stderr)