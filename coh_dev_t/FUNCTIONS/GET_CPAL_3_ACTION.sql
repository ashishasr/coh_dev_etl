--------------------------------------------------------
--  DDL for Function GET_CPAL_3_ACTION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CPAL_3_ACTION" (in_no_of_rehabs varchar)
return varchar
is
out_cpal_3_action varchar(100);
begin
SELECT
    CASE 
        WHEN in_no_of_rehabs = 0 OR in_no_of_rehabs = 2 THEN 'Replace'
        ELSE 'Rehab'
    END
into out_cpal_3_action from dual;
return out_cpal_3_action;
end;

/
