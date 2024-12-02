--------------------------------------------------------
--  DDL for Function GET_CPAL_1_ACTION_TIMEFRAME_BR1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CPAL_1_ACTION_TIMEFRAME_BR1" (in_br1  varchar)
return varchar
is
out_cpal_1_action_timeframe_br1 varchar(100);
begin
SELECT
    CASE
        WHEN in_br1 = 'URGENT' THEN 0
        WHEN in_br1 = 'PRIORITY' THEN 3
        WHEN in_br1 = 'SHORT-TERM' THEN 6
        WHEN in_br1 = 'MID-TERM' THEN 11
        WHEN in_br1 = 'LONG-TERM' THEN 21
        ELSE NULL
    END
into out_cpal_1_action_timeframe_br1 from dual;
return out_cpal_1_action_timeframe_br1;
end;

/
