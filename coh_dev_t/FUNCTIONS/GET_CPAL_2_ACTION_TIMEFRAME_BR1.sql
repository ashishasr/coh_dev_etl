--------------------------------------------------------
--  DDL for Function GET_CPAL_2_ACTION_TIMEFRAME_BR1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CPAL_2_ACTION_TIMEFRAME_BR1" (in_no_of_rehabs  varchar, in_first_action_timeframe_br1 varchar, 
in_rehab_eul varchar, 
in_replacement_eul varchar)
return varchar
is
out_cpal_2_action_timeframe_br1 varchar(100);
begin
SELECT
    CEIL(
        CASE 
            WHEN in_no_of_rehabs > 2 THEN in_first_action_timeframe_br1 + in_rehab_eul
            ELSE in_replacement_eul + in_first_action_timeframe_br1
        END
    )
into out_cpal_2_action_timeframe_br1 from dual;
return out_cpal_2_action_timeframe_br1;
end;

/
