--------------------------------------------------------
--  DDL for Function GET_COST_OVERIDE_GENERAL_CONDITION_5_PERC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_COST_OVERIDE_GENERAL_CONDITION_5_PERC" (
in_labor number, 
in_equipment_cost number
)
    return varchar
        is
            out_general_condition_5_perc varchar(100);
        begin
            SELECT 
            0.05 * (NVL(in_labor, 0) + NVL(in_equipment_cost, 0))
            into out_general_condition_5_perc from dual;
            return out_general_condition_5_perc;
        end;

/
