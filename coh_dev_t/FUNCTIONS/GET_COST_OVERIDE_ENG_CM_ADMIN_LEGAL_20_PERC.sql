--------------------------------------------------------
--  DDL for Function GET_COST_OVERIDE_ENG_CM_ADMIN_LEGAL_20_PERC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_COST_OVERIDE_ENG_CM_ADMIN_LEGAL_20_PERC" (
in_labor number, 
in_equipment_cost number
)
    return varchar
        is
            out_ENG_CM_ADMIN_LEGAL_20_perc varchar(100);
        begin
            SELECT 
            0.2 * (NVL(in_labor, 0) + NVL(in_equipment_cost, 0))
            into out_ENG_CM_ADMIN_LEGAL_20_perc from dual;
            return out_ENG_CM_ADMIN_LEGAL_20_perc;
        end;

/
