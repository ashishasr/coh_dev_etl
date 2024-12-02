--------------------------------------------------------
--  DDL for Function GET_COF_RATING
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_COF_RATING" (in_cof_score number)
return varchar
is
out_cof_rating varchar(100);
begin
SELECT
    CASE 
        WHEN in_cof_score > 4 THEN 'HIGH'
        WHEN in_cof_score <= 4 AND in_cof_score > 3 THEN 'MEDIUM-HIGH'
        WHEN in_cof_score <= 3 AND in_cof_score > 2 THEN 'MEDIUM'
        WHEN in_cof_score <= 2 AND in_cof_score > 1 THEN 'MEDIUM-LOW'
        WHEN in_cof_score <= 1 AND in_cof_score >= 0 THEN 'LOW'
        ELSE '0' 
    END 
into out_cof_rating from dual;
return out_cof_rating;
end;

/
