with source as (

    select * from {{ ref('college_playing') }}

),

renamed as (

    select
        "playerID" as player_id,
        "schoolID" as school_id,
        -- NULL for Negro League college records (years unknown)
        "yearID" as year_id

    from source

)

select * from renamed
