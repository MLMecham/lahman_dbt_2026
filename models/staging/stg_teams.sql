with source as (

    select * from {{ ref('teams') }}

),

renamed as (

    select
        "yearID" as year_id,
        "lgID" as league_id,
        "teamID" as team_id,
        "franchID" as franchise_id,
        "divID" as division_id,
        "Rank" as team_rank,
        "G" as games,
        "Ghome" as home_games,
        "W" as wins,
        "L" as losses,
        -- Y/N flags: preserve NULL as unknown (e.g. pre-divisional and Negro League eras)
        case when "DivWin" = 'Y' then true when "DivWin" = 'N' then false end as won_division,
        case when "WCWin" = 'Y' then true when "WCWin" = 'N' then false end as won_wild_card,
        case when "LgWin" = 'Y' then true when "LgWin" = 'N' then false end as won_league,
        case when "WSWin" = 'Y' then true when "WSWin" = 'N' then false end as won_world_series,
        "R" as runs_scored,
        "AB" as at_bats,
        "H" as hits,
        "2B" as doubles,
        "3B" as triples,
        "HR" as home_runs,
        "BB" as walks,
        "SO" as strikeouts,
        "SB" as stolen_bases,
        "CS" as caught_stealing,
        "HBP" as hit_by_pitch,
        "SF" as sacrifice_flies,
        "RA" as runs_allowed,
        "ER" as earned_runs_allowed,
        "ERA" as era,
        "CG" as complete_games,
        "SHO" as shutouts,
        "SV" as saves,
        "IPouts" as outs_pitched,
        "HA" as hits_allowed,
        "HRA" as home_runs_allowed,
        "BBA" as walks_allowed,
        "SOA" as strikeouts_pitched,
        "E" as errors,
        "DP" as double_plays,
        "FP" as fielding_pct,
        "name" as team_name,
        "park" as park_name,
        "attendance" as attendance,
        "BPF" as batter_park_factor,
        "PPF" as pitcher_park_factor,
        "teamIDBR" as team_id_bbref,
        "teamIDlahman45" as team_id_lahman45,
        "teamIDretro" as team_id_retro

    from source

)

select * from renamed
