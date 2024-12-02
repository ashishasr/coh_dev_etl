--------------------------------------------------------
--  DDL for Function GET_AMC_PREDICTED_REPLACEMENT_YEAR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_AMC_PREDICTED_REPLACEMENT_YEAR" 
    ( in_ca_life_remaining number)
    return number
        is
            out_predicted_replacement_year  varchar(100);
        begin
SELECT 
    EXTRACT(YEAR FROM SYSDATE) + in_ca_life_remaining
            into out_predicted_replacement_year from dual;
            return out_predicted_replacement_year;
        end;

/
