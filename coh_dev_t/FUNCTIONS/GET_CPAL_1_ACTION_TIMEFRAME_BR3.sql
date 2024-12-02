--------------------------------------------------------
--  DDL for Function GET_CPAL_1_ACTION_TIMEFRAME_BR3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CPAL_1_ACTION_TIMEFRAME_BR3" (in_br3  varchar)
return varchar
is
out_cpal_1_action_timeframe_br3 varchar(100);
begin
SELECT
    CASE
        WHEN in_br3 = 'URGENT' THEN 0
        WHEN in_br3 = 'PRIORITY' THEN 3
        WHEN in_br3 = 'SHORT-TERM' THEN 6
        WHEN in_br3 = 'MID-TERM' THEN 11
        WHEN in_br3 = 'LONG-TERM' THEN 20
        ELSE NULL
    END
into out_cpal_1_action_timeframe_br3 from dual;
return out_cpal_1_action_timeframe_br3;
end;

/
