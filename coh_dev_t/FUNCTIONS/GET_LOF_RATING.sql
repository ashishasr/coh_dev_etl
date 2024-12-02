--------------------------------------------------------
--  DDL for Function GET_LOF_RATING
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_LOF_RATING" (in_lof_score varchar)
return varchar
is
out_lof_rating varchar(100);
begin
SELECT
    CASE
        WHEN in_lof_score = 5 THEN 'HIGH'
        WHEN in_lof_score = 4 THEN 'MEDIUM-HIGH'
        WHEN in_lof_score = 3 THEN 'MEDIUM'
        WHEN in_lof_score = 2 THEN 'MEDIUM-LOW'
        WHEN in_lof_score = 1 THEN 'LOW'
        ELSE 'Unknown'
    END
into out_lof_rating from dual;
return out_lof_rating;
end;

/
