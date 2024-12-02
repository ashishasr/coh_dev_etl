--------------------------------------------------------
--  DDL for Function GET_CPAL_TIMEFRAME
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CPAL_TIMEFRAME" (in_br3 varchar)
return varchar
is
out_timeframe varchar(100);
begin
SELECT 
    CASE 
        WHEN in_br3 = 'URGENT' THEN '0-2 Years'
        WHEN in_br3 = 'PRIORITY' THEN '3-5 Years'
        WHEN in_br3 = 'SHORT-TERM' THEN '6-10 Years'
        WHEN in_br3 = 'MID-TERM' THEN '11-20 Years'
        WHEN in_br3 = 'LONG-TERM' THEN '20+ Years'
        ELSE ''
    END
into out_timeframe from dual;
return out_timeframe;
end;

/
