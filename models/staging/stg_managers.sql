with source as (

    select * from {{ ref('managers') }}

),

renamed as (

    select
        "playerID" as player_id,
        "yearID" as year_id,
        "teamID" as team_id,
        "lgID" as league_id,
        "inseason" as inseason_order,
        "G" as games,
        "W" as wins,
        "L" as losses,
        "rank" as team_rank,
        case when "plyrMgr" = 'Y' then true when "plyrMgr" = 'N' then false end as is_player_manager

    from source

)

select * from renamed
