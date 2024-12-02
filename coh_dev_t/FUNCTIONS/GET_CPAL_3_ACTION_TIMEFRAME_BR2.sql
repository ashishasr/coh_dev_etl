--------------------------------------------------------
--  DDL for Function GET_CPAL_3_ACTION_TIMEFRAME_BR2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CPAL_3_ACTION_TIMEFRAME_BR2" (in_no_of_rehabs  varchar, in_second_action_timeframe_br2 varchar, 
in_rehab_eul varchar, 
in_replacement_eul varchar)
return varchar
is
out_cpal_3_action_timeframe_br2 varchar(100);
begin
SELECT
    CEIL(
        CASE 
            WHEN in_no_of_rehabs > 3 THEN in_second_action_timeframe_br2 + in_rehab_eul
            ELSE in_second_action_timeframe_br2 + in_replacement_eul
        END
    )
into out_cpal_3_action_timeframe_br2 from dual;
return out_cpal_3_action_timeframe_br2;
end;

/
