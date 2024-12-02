--------------------------------------------------------
--  DDL for Function GET_COST_OVERIDE_SUBTOTAL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_COST_OVERIDE_SUBTOTAL" (
in_labor number, 
in_equipment_cost number,
in_general_conditions_5 number,
in_contract_oh_profit_15 number,
in_eng_cm_admin_legal_20 number
)
    return varchar
        is
            out_subtotal varchar(100);
        begin
            SELECT 
        NVL(in_labor, 0) + 
        NVL(in_equipment_cost, 0) + 
        NVL(in_general_conditions_5, 0) +
        NVL(in_contract_oh_profit_15, 0) + 
        NVL(in_eng_cm_admin_legal_20, 0)
            into out_subtotal from dual;
            return out_subtotal;
        end;

/
