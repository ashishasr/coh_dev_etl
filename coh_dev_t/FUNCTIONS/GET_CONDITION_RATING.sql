--------------------------------------------------------
--  DDL for Function GET_CONDITION_RATING
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CONDITION_RATING" (in_condition_score varchar)
return varchar
is
out_condition_rating varchar(100);
begin
SELECT
    CASE
        WHEN in_condition_score = 5 THEN 'Very Poor'
        WHEN in_condition_score = 4 THEN 'Poor'
        WHEN in_condition_score = 3 THEN 'Moderate'
        WHEN in_condition_score = 2 THEN 'Good'
        WHEN in_condition_score = 1 THEN 'Excellent'
        ELSE 'Very Poor'
    END
into out_condition_rating from dual;
return out_condition_rating;
end;

/
