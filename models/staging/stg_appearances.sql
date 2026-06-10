with source as (

    select * from {{ ref('appearances') }}

),

renamed as (

    select
        "yearID" as year_id,
        "teamID" as team_id,
        "lgID" as league_id,
        "playerID" as player_id,
        "G_all" as games_total,
        "GS" as games_started,
        "G_batting" as games_batting,
        "G_defense" as games_defense,
        "G_p" as games_pitcher,
        "G_c" as games_catcher,
        "G_1b" as games_first_base,
        "G_2b" as games_second_base,
        "G_3b" as games_third_base,
        "G_ss" as games_shortstop,
        "G_lf" as games_left_field,
        "G_cf" as games_center_field,
        "G_rf" as games_right_field,
        "G_of" as games_outfield,
        "G_dh" as games_dh,
        "G_ph" as games_pinch_hitter,
        "G_pr" as games_pinch_runner

    from source

)

select * from renamed
