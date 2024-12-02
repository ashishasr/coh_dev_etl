--------------------------------------------------------
--  DDL for Function GET_CPAL_1_ACTION_TIMEFRAME_BR2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CPAL_1_ACTION_TIMEFRAME_BR2" (in_br2  varchar)
return varchar
is
out_cpal_1_action_timeframe_br2 varchar(100);
begin
SELECT
    CASE
        WHEN in_br2 = 'URGENT' THEN 0
        WHEN in_br2 = 'PRIORITY' THEN 3
        WHEN in_br2 = 'SHORT-TERM' THEN 6
        WHEN in_br2 = 'MID-TERM' THEN 11
        WHEN in_br2 = 'LONG-TERM' THEN 20
        ELSE NULL
    END
into out_cpal_1_action_timeframe_br2 from dual;
return out_cpal_1_action_timeframe_br2;
end;

/
