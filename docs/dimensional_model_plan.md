# Lahman 2025 Kimball Star Schema — Dimensional Model Plan

Status: **planning approved, no marts code written yet** (decided 2026-06-09).
Stack: dbt Fusion + Snowflake. Seeds = Lahman 1871–2025 CSVs. Possible Streamlit/Looker Studio app later.

## Design decisions (locked)

1. **Scope**: Base = core performance stars + technique showcase + salary + attendance
   (salary/attendance promoted from stretch because they're the most interesting for analysis).
   Everything else is a stretch menu — pull items only when the app needs them.
2. **dim_team**: SCD2 *compressed* — collapse consecutive identical team-years into change
   rows with `valid_from_year`/`valid_to_year`/`is_current`. Facts join on
   `team_id` + `year_id BETWEEN valid_from_year AND valid_to_year`.
3. **Accumulating snapshot**: player career lifecycle (one row per player).
4. **Postseason**: separate fact tables from regular season (grains differ: stint vs round).
   Postseason facts are stretch.

## Base scope — fact tables

| Fact | Grain | Type | Notes |
|------|-------|------|-------|
| `fct_batting` | player × team × season × stint | Periodic snapshot | Additive counting stats; AVG/OBP/SLG/OPS are non-additive — recompute from components, never average averages. `stint` is a degenerate dimension. |
| `fct_pitching` | player × team × season × stint | Periodic snapshot | Additive: W, L, IPouts, SO, BB, ER, BFP… Non-additive ERA/BAOpp recomputed from ER+IPouts / H+BFP components. |
| `fct_team_season` | team × season | Periodic snapshot | Additive across teams within a year (R, H, attendance); non-additive: rank, ERA, FP, BPF/PPF. Win flags (DivWin/WCWin/LgWin/WSWin). |
| `fct_salary` | player × team × season | Periodic snapshot | Fully additive (payroll across players, career earnings across years). **Coverage 1985–2016 only — document.** |
| `fct_home_attendance` | team × park × season | Periodic snapshot | Additive: games, openings, attendance. Doubles as the team↔park M:M bridge. span_first/span_last as degenerate dates. |
| `fct_award_win` | player × award × season × league | **Factless** | Event = won the award; `tie` flag, notes degenerate. |
| `fct_hof_ballot` | player × ballot-year | **Transaction** | votes, ballots, needed; vote_pct non-additive; inducted flag. |
| `fct_player_career` | player | **Accumulating snapshot** | Milestone FKs: debut, first All-Star, first award, first HOF ballot, final game, HOF induction. Lag measures: career_length_years, years_retirement_to_induction, ballots_to_induction. Counts: allstar_selections, awards_won. |
| `fct_career_running_totals` | player × season | Periodic snapshot, **semi-additive** | Career-to-date cumulative HR/H/SO/etc. via window functions. MAX/LAST across years is valid, SUM is not — the semi-additive showcase. |

## Base scope — dimensions

| Dimension | SCD | Notes |
|-----------|-----|-------|
| `dim_player` | 0/1 | From People. Type 0: birth info, debut. Natural key `player_id`; bats/throws/height/weight; bbref/retro IDs as cross-refs. |
| `dim_team` | **2** | Built from Teams via gaps-and-islands compression on (name, park, division, league, franchise). |
| `dim_franchise` | 0 | From TeamsFranchises. `na_assoc` lineage resolved with a **recursive CTE**. Also flattened (franchise name) onto dim_team for usability. |
| `dim_season` | 0 | One row per year 1871–2025. Era labels (dead-ball, live-ball, integration, expansion, free-agency, wild-card, modern), decade, DH flags, negro-league-active flag. The conformed time dimension (year grain). |
| `dim_park` | 1 | From Parks: name, aliases, city/state/country. |
| `dim_position` | 0 | Small static seed: position code, name, IF/OF/battery grouping. |
| `dim_award` | 1 | Distinct awards from award tables; player vs manager category. |
| `dim_league` | 0 | lgID (3-char for Negro Leagues), league full name, classification (AL/NL/historical/Negro League/independent). |
| `dim_school` + `bridge_player_school` | 0 | CollegePlaying M:M bridge. School renames (year-suffixed IDs like `illinoisst1857` → `illinoisst`) resolved with a **recursive CTE**; bridge carries both historical and current school keys. Data only through 2014. |

Date handling: `dim_season` (year grain) is the conformed time dimension; full dates
(debut, final game, attendance spans) stay as degenerate date attributes — no day-grain
dim_date unless the app needs one.

## Stretch menu (no new techniques — pull on demand)

`fct_fielding` (player × team × season × stint × position), `fct_batting_post` /
`fct_pitching_post` / `fct_fielding_post` (player × team × season × round, + `dim_round`),
`fct_postseason_series`, `fct_allstar_selection` (factless), `fct_manager_season`,
`fct_award_vote` (AwardsShare voting), TeamsHalf/ManagersHalf split-season facts.

## Layering & conventions

- `staging/`: one `stg_<table>` per seed — rename to snake_case, cast types, `'' → NULL`.
  Lahman NULL semantics: NULL = unknown (esp. Negro League & pre-1900 data) — never coalesce to 0.
- `intermediate/`: `int_team_scd2` (compression), `int_player_milestones` (career accum-snapshot prep),
  `int_career_running` (window functions).
- `marts/`: dims + facts above. Surrogate keys via `dbt_utils.generate_surrogate_key`.
- Tests: unique + not_null on every PK/SK, `relationships` from fact FKs to dims,
  `accepted_values` on flags; source freshness n/a (static seeds).

## Known data limitations to document in YAML

- Salaries: 1985–2016 only. CollegePlaying/Schools: through 2014. FieldingOF: through 1955.
- Negro League data: player-level may not sum to team-level; lgID needs 3 chars;
  1939 Toledo Crawfords have two teamIDs (TC, TC2) under one franchise (PC).
- Teams table W/L for Negro League = in-league record, player data = vs all clubs.
