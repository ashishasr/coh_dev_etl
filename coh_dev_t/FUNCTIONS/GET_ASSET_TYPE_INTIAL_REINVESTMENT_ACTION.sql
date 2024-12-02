--------------------------------------------------------
--  DDL for Function GET_ASSET_TYPE_INTIAL_REINVESTMENT_ACTION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_ASSET_TYPE_INTIAL_REINVESTMENT_ACTION" (in_max_no_of_rehabs varchar)
    return varchar
        is
            out_intial_reinvestment_action varchar(100);
        begin
            SELECT 
  CASE 
    WHEN in_max_no_of_rehabs <> 0 THEN 'Rehab' 
    ELSE 'Replace' 
  END
            into out_intial_reinvestment_action from dual;
            return out_intial_reinvestment_action;
        end;

/
