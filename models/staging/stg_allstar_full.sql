with source as (

    select * from {{ ref('allstar_full') }}

),

renamed as (

    select
        "playerID" as player_id,
        "yearID" as year_id,
        "gameNum" as game_num,
        "gameID" as game_id,
        "teamID" as team_id,
        "lgID" as league_id,
        "GP" as games_played,
        -- can hold multiple positions like '3;6' for Negro League cumulative records
        "startingPos" as starting_pos

    from source

)

select * from renamed
