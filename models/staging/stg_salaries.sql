with source as (

    select * from {{ ref('salaries') }}

),

renamed as (

    select
        "yearID" as year_id,
        "teamID" as team_id,
        "lgID" as league_id,
        "playerID" as player_id,
        "salary" as salary

    from source

)

select * from renamed
