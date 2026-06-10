with source as (

    select * from {{ ref('parks') }}

),

renamed as (

    select
        "ID" as park_row_id,
        "parkkey" as park_id,
        "parkname" as park_name,
        "parkalias" as park_alias,
        "city" as city,
        "state" as state,
        "country" as country

    from source

)

select * from renamed
