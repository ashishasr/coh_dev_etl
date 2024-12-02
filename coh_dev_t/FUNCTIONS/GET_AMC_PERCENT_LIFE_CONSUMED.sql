--------------------------------------------------------
--  DDL for Function GET_AMC_PERCENT_LIFE_CONSUMED
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_AMC_PERCENT_LIFE_CONSUMED" (in_estimated_useful_life number, in_life_remaining number)
    return varchar
        is
            out_percent_life_consumed varchar(100);
        begin
          SELECT 
    CASE 
        WHEN in_estimated_useful_life IS NULL OR in_estimated_useful_life = 0 
        THEN 0 
        ELSE (in_estimated_useful_life - in_life_remaining) / in_estimated_useful_life 
    END
            into out_percent_life_consumed from dual;
            return out_percent_life_consumed;
        end;

/
