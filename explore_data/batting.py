# %%
import polars as pl
from pathlib import Path

# %%
file = Path(__file__).parent.parent / "seeds" / "batting.csv"
# %%
batting = pl.read_csv(file)
batting
# %%
