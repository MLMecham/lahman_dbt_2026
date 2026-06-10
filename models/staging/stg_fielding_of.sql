with source as (

    select * from {{ ref('fielding_of') }}

),

renamed as (

    select
        "playerID" as player_id,
        "yearID" as year_id,
        "stint" as stint,
        "Glf" as games_left_field,
        "Gcf" as games_center_field,
        "Grf" as games_right_field

    from source

)

select * from renamed
