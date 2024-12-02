--------------------------------------------------------
--  DDL for Function GET_COST_OVERRIDE_CONTINGENCY_25
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_COST_OVERRIDE_CONTINGENCY_25" (
in_subtotal number
)
    return varchar
        is
            out_contingency_25 varchar(100);
        begin
            SELECT 
            in_subtotal*0.25
            into out_contingency_25 from dual;
            return out_contingency_25;
        end;

/
