with source as (

    select * from {{ ref('schools') }}

),

renamed as (

    select
        "schoolID" as school_id,
        "name_full" as school_name,
        "city" as city,
        "state" as state,
        "country" as country

    from source

)

select * from renamed
