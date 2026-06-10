with source as (

    select * from {{ ref('managers_half') }}

),

renamed as (

    select
        "playerID" as player_id,
        "yearID" as year_id,
        "teamID" as team_id,
        "lgID" as league_id,
        "inseason" as inseason_order,
        "half" as season_half,
        "G" as games,
        "W" as wins,
        "L" as losses,
        "rank" as team_rank

    from source

)

select * from renamed
