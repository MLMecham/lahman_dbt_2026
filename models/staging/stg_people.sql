with source as (

    select * from {{ ref('people') }}

),

renamed as (

    select
        "ID" as people_row_id,
        "playerID" as player_id,
        "birthYear" as birth_year,
        "birthMonth" as birth_month,
        "birthDay" as birth_day,
        "birthCity" as birth_city,
        "birthState" as birth_state,
        "birthCountry" as birth_country,
        "deathYear" as death_year,
        "deathMonth" as death_month,
        "deathDay" as death_day,
        "deathCity" as death_city,
        "deathState" as death_state,
        "deathCountry" as death_country,
        "nameFirst" as name_first,
        "nameLast" as name_last,
        "nameGiven" as name_given,
        "weight" as weight_lbs,
        "height" as height_inches,
        "bats" as bats,
        "throws" as throws,
        "debut"::date as debut_date,
        "finalGame"::date as final_game_date,
        "bbrefID" as bbref_id,
        "retroID" as retro_id

    from source

)

select * from renamed
