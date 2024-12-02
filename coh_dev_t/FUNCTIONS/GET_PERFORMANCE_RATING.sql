--------------------------------------------------------
--  DDL for Function GET_PERFORMANCE_RATING
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_PERFORMANCE_RATING" (in_performance_score varchar)
return varchar
is
out_performance_rating varchar(100);
begin
SELECT
    CASE
        WHEN in_performance_score = 5 THEN 'Very Poor'
        WHEN in_performance_score = 4 THEN 'Poor'
        WHEN in_performance_score = 3 THEN 'Moderate'
        WHEN in_performance_score = 2 THEN 'Good'
        WHEN in_performance_score = 1 THEN 'Excellent'
        ELSE 'Unknown'
    END
into out_performance_rating from dual;
return out_performance_rating;
end;

/
