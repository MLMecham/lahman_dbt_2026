with source as (

    select * from {{ ref('batting_post') }}

),

renamed as (

    select
        "yearID" as year_id,
        "round" as round,
        "playerID" as player_id,
        "teamID" as team_id,
        "lgID" as league_id,
        "G" as games,
        "AB" as at_bats,
        "R" as runs,
        "H" as hits,
        "2B" as doubles,
        "3B" as triples,
        "HR" as home_runs,
        "RBI" as runs_batted_in,
        "SB" as stolen_bases,
        "CS" as caught_stealing,
        "BB" as walks,
        "SO" as strikeouts,
        "IBB" as intentional_walks,
        "HBP" as hit_by_pitch,
        "SH" as sacrifice_hits,
        "SF" as sacrifice_flies,
        "GIDP" as grounded_into_double_plays

    from source

)

select * from renamed
