--------------------------------------------------------
--  DDL for Function GET_LOF_SCORE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_LOF_SCORE" (in_condition_score number, in_performance_score number)
return varchar
is
out_lof_score varchar(100);
begin
SELECT
    CASE
        WHEN in_condition_score IS NOT NULL AND in_performance_score IS NOT NULL THEN 
            GREATEST(in_condition_score, in_performance_score)
        WHEN in_condition_score IS NOT NULL AND in_performance_score IS NULL THEN 
            in_condition_score
        WHEN in_condition_score IS NULL AND in_performance_score IS NOT NULL THEN 
            in_performance_score
        WHEN in_condition_score IS NULL THEN 
            NULL
        ELSE 
            0
    END
into out_lof_score from dual;
return out_lof_score;
end;

/
