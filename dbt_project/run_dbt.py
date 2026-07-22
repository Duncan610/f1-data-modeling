import subprocess

result = subprocess.run(
    ["dbt", "run", "--select", "stg_races",
     "--project-dir", "/Workspace/f1_project/f1-data-modeling/dbt_project",
     "--profiles-dir", "/Workspace/f1_project/f1-data-modeling/dbt_project"],
    capture_output=True, text=True
)
print(result.stdout)
print(result.stderr)