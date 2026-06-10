with source as (

    select * from {{ ref('pitching') }}

),

renamed as (

    select
        "playerID" as player_id,
        "yearID" as year_id,
        "stint" as stint,
        "teamID" as team_id,
        "lgID" as league_id,
        "W" as wins,
        "L" as losses,
        "G" as games,
        "GS" as games_started,
        "CG" as complete_games,
        "SHO" as shutouts,
        "SV" as saves,
        "IPouts" as outs_pitched,
        "H" as hits_allowed,
        "ER" as earned_runs,
        "HR" as home_runs_allowed,
        "BB" as walks_allowed,
        "SO" as strikeouts,
        "BAOpp" as opp_batting_avg,
        "ERA" as era,
        "IBB" as intentional_walks,
        "WP" as wild_pitches,
        "HBP" as batters_hit_by_pitch,
        "BK" as balks,
        "BFP" as batters_faced,
        "GF" as games_finished,
        "R" as runs_allowed,
        "SH" as sacrifice_hits_allowed,
        "SF" as sacrifice_flies_allowed,
        "GIDP" as double_plays_induced

    from source

)

select * from renamed
