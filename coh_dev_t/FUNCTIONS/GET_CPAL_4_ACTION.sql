--------------------------------------------------------
--  DDL for Function GET_CPAL_4_ACTION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CPAL_4_ACTION" (in_no_of_rehabs  varchar)
return varchar
is
out_cpal_4_action varchar(100);
begin
SELECT
    CASE
        WHEN in_no_of_rehabs IN (0, 1, 3) THEN 'Replace'
        ELSE 'Rehab'
    END
into out_cpal_4_action from dual;
return out_cpal_4_action;
end;

/
