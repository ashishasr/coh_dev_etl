--------------------------------------------------------
--  DDL for Function GET_AMC_CA_LIFE_REMAINING
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_AMC_CA_LIFE_REMAINING" 
    (in_condition_adjusted_useful_life number, in_age number)
    return number
        is
            out_ca_life_remaining   varchar(100);
        begin
         SELECT 
    CASE 
        WHEN in_condition_adjusted_useful_life - in_age >= 0 
        THEN in_condition_adjusted_useful_life - in_age 
        ELSE 0 
    END
            into out_ca_life_remaining from dual;
            return out_ca_life_remaining;
        end;


/
