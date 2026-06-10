with source as (

    select * from {{ ref('fielding_post') }}

),

renamed as (

    select
        "playerID" as player_id,
        "yearID" as year_id,
        "teamID" as team_id,
        "lgID" as league_id,
        "round" as round,
        "POS" as position,
        "G" as games,
        "GS" as games_started,
        "InnOuts" as inn_outs,
        "PO" as putouts,
        "A" as assists,
        "E" as errors,
        "DP" as double_plays,
        "TP" as triple_plays,
        "PB" as passed_balls,
        "SB" as stolen_bases_allowed,
        "CS" as caught_stealing

    from source

)

select * from renamed
