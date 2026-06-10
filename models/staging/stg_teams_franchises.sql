with source as (

    select * from {{ ref('teams_franchises') }}

),

renamed as (

    select
        "franchID" as franchise_id,
        "franchName" as franchise_name,
        -- left as text: holds 'Y'/'N' plus 'NA' for National Association franchises
        "active" as active,
        "NAassoc" as na_assoc_franchise_id

    from source

)

select * from renamed
