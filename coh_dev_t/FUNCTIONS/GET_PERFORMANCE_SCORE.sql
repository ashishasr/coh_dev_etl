--------------------------------------------------------
--  DDL for Function GET_PERFORMANCE_SCORE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_PERFORMANCE_SCORE" 
(
in_capacity varchar,
in_reliability varchar,
in_o_m varchar,
in_obsolescence varchar,
in_redundancy varchar
)
return varchar
is
out_performance_score varchar(100);
begin
SELECT 
    NVL(
        GREATEST(
            TO_NUMBER(SUBSTR(in_capacity, 1, 1)), 
            TO_NUMBER(SUBSTR(in_reliability, 1, 1)), 
            TO_NUMBER(SUBSTR(in_o_m, 1, 1)), 
            TO_NUMBER(SUBSTR(in_obsolescence, 1, 1)), 
            TO_NUMBER(SUBSTR(in_redundancy, 1, 1))
        ), 
        0
    )
into out_performance_score from dual;
return out_performance_score;
end;

/
