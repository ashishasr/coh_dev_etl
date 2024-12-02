--------------------------------------------------------
--  DDL for Function GET_AMC_LIFE_REMAINING
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_AMC_LIFE_REMAINING" (in_estimated_useful_life_eul number, in_age number)
    return varchar
        is
            out_get_life_remaining varchar(100);
        begin
            SELECT 
    CASE 
        WHEN (in_estimated_useful_life_eul - in_age) >= 0 
        THEN (in_estimated_useful_life_eul - in_age) 
        ELSE 0 
    END
            into out_get_life_remaining from dual;
            return out_get_life_remaining;
        end;

/
