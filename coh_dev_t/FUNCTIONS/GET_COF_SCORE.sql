--------------------------------------------------------
--  DDL for Function GET_COF_SCORE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_COF_SCORE" 
(
in_replacement_Cost varchar,
in_om_impact varchar,
in_level_of_service varchar,
in_health_and_safety varchar,
in_permit_compliance varchar,
in_response_time varchar,
in_service_priority varchar
)
return number
is
out_get_cof_score number;
begin
SELECT 
    COALESCE(
        ROUND(
            (
                GREATEST(
                    TO_NUMBER(SUBSTR(in_replacement_Cost, 1, 1)),
                    TO_NUMBER(SUBSTR(in_om_impact, 1, 1))
                ) +
                GREATEST(
                    TO_NUMBER(SUBSTR(in_level_of_service, 1, 1)),
                    TO_NUMBER(SUBSTR(in_health_and_safety, 1, 1))
                ) +
                GREATEST(
                    TO_NUMBER(SUBSTR(in_permit_compliance, 1, 1)),
                    TO_NUMBER(SUBSTR(in_response_time, 1, 1)),
                    TO_NUMBER(SUBSTR(in_service_priority, 1, 1))
                )
            ) / 3, 
        2),
        0
    )
    into out_get_cof_score from dual;
        return out_get_cof_score;
end;

/
