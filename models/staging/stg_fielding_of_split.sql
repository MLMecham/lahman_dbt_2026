with source as (

    select * from {{ ref('fielding_of_split') }}

),

renamed as (

    select
        "playerID" as player_id,
        "yearID" as year_id,
        "stint" as stint,
        "teamID" as team_id,
        "lgID" as league_id,
        "POS" as position,
        "G" as games,
        "GS" as games_started,
        "InnOuts" as inn_outs,
        "PO" as putouts,
        "A" as assists,
        "E" as errors,
        "DP" as double_plays,
        "PB" as passed_balls,
        "WP" as wild_pitches,
        "SB" as stolen_bases_allowed,
        "CS" as caught_stealing,
        "ZR" as zone_rating

    from source

)

select * from renamed
