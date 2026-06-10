with source as (

    select * from {{ ref('teams_half') }}

),

renamed as (

    select
        "yearID" as year_id,
        "lgID" as league_id,
        "teamID" as team_id,
        "Half" as season_half,
        "divID" as division_id,
        case when "DivWin" = 'Y' then true when "DivWin" = 'N' then false end as won_division,
        "Rank" as team_rank,
        "G" as games,
        "W" as wins,
        "L" as losses

    from source

)

select * from renamed
