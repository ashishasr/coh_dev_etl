--------------------------------------------------------
--  DDL for Function GET_AMC_PREDICTED_CIP_YEAR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_AMC_PREDICTED_CIP_YEAR" 
    ( in_ca_life_remaining varchar)
    return number
        is
            out_get_predicted_cip_year  varchar(100);
        begin
SELECT 
    CASE
        WHEN in_ca_life_remaining IS NULL OR in_ca_life_remaining = '' THEN ''
        WHEN in_ca_life_remaining <= 3 THEN '0 to 3'
        WHEN in_ca_life_remaining > 3 AND in_ca_life_remaining <= 5 THEN '3 to 5'
        WHEN in_ca_life_remaining > 5 AND in_ca_life_remaining <= 10 THEN '5 to 10'
        WHEN in_ca_life_remaining > 10 AND in_ca_life_remaining <= 20 THEN '10 to 20'
        ELSE '>20'
    END
            into out_get_predicted_cip_year from dual;
            return out_get_predicted_cip_year;
        end;

/
