with source as (

    select * from {{ ref('home_games') }}

),

renamed as (

    select
        "yearkey" as year_id,
        "leaguekey" as league_id,
        "teamkey" as team_id,
        "parkkey" as park_id,
        "spanfirst"::date as span_first_date,
        "spanlast"::date as span_last_date,
        "games" as games,
        "openings" as openings,
        "attendance" as attendance

    from source

)

select * from renamed
