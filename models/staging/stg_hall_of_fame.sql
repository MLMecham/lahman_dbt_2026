with source as (

    select * from {{ ref('hall_of_fame') }}

),

renamed as (

    select
        "playerID" as player_id,
        "yearid" as year_id,
        "votedBy" as voted_by,
        "ballots" as ballots,
        "needed" as needed,
        "votes" as votes,
        case when "inducted" = 'Y' then true when "inducted" = 'N' then false end as was_inducted,
        "category" as category,
        "needed_note" as needed_note

    from source

)

select * from renamed
