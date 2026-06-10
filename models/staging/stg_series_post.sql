with source as (

    select * from {{ ref('series_post') }}

),

renamed as (

    select
        "yearID" as year_id,
        "round" as round,
        "teamIDwinner" as team_id_winner,
        "lgIDwinner" as league_id_winner,
        "teamIDloser" as team_id_loser,
        "lgIDloser" as league_id_loser,
        "wins" as wins,
        "losses" as losses,
        "ties" as ties

    from source

)

select * from renamed
