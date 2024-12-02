--------------------------------------------------------
--  DDL for Function GET_CPAL_2_ACTION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CPAL_2_ACTION" (in_no_of_rehabs varchar)
return varchar
is
out_cpal_2_action varchar(100);
begin
SELECT 
    CASE 
        WHEN in_no_of_rehabs > 1 THEN 'Rehab'
        ELSE 'Replace'
    END
into out_cpal_2_action from dual;
return out_cpal_2_action;
end;

/
