# ingestion/test_connectivity.py

import requests

urls = {
    "GitHub (FastF1 schedule cache)": "https://raw.githubusercontent.com/theOehrly/f1schedule/master/README.md",
    "F1 live timing API": "https://livetiming.formula1.com/static/",
    "Jolpica-F1 (known working)": "https://api.jolpi.ca/ergast/f1/2023/1/results.json",
}

for name, url in urls.items():
    try:
        r = requests.get(url, timeout=10)
        print(f"{name}: status {r.status_code}")
    except Exception as e:
        print(f"{name}: FAILED - {type(e).__name__}: {e}")