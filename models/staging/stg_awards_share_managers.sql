with source as (

    select * from {{ ref('awards_share_managers') }}

),

renamed as (

    select
        "awardID" as award_id,
        "yearID" as year_id,
        "lgID" as league_id,
        "playerID" as player_id,
        "pointsWon" as points_won,
        "pointsMax" as points_max,
        "votesFirst" as votes_first

    from source

)

select * from renamed
