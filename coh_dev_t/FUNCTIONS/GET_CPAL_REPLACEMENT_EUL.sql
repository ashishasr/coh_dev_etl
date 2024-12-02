--------------------------------------------------------
--  DDL for Function GET_CPAL_REPLACEMENT_EUL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CPAL_REPLACEMENT_EUL" (in_condition_adjusted_useful_life number)
    return varchar
        is
            out_cpal_replacement_eul varchar(100);
        begin
            SELECT 
        in_condition_adjusted_useful_life
            into out_cpal_replacement_eul from dual;
            return out_cpal_replacement_eul;
        end;

/
