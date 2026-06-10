with source as (

    select * from {{ ref('awards_players') }}

),

renamed as (

    select
        "playerID" as player_id,
        "awardID" as award_id,
        "yearID" as year_id,
        "lgID" as league_id,
        case when "tie" = 'Y' then true when "tie" = 'N' then false end as is_tie,
        "notes" as notes

    from source

)

select * from renamed
