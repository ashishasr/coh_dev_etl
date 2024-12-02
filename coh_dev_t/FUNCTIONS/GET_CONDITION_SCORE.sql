--------------------------------------------------------
--  DDL for Function GET_CONDITION_SCORE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CONDITION_SCORE" 
(
in_condition_A1 varchar,
in_condition_A2 varchar,
in_condition_A3 varchar,
in_condition_A4 varchar,
in_condition_A5 varchar,
in_condition_A6 varchar,
in_condition_A7 varchar,
in_condition_A8 varchar,
in_condition_A9 varchar,
in_condition_A10 varchar
)
return varchar
is
out_condition_score varchar(100);
begin
SELECT GREATEST(in_condition_A1, in_condition_A2, in_condition_A3
, in_condition_A4, in_condition_A5, in_condition_A6, in_condition_A7, 
in_condition_A8, in_condition_A9, in_condition_A10)
into out_condition_score from dual;
return out_condition_score;
end;

/
