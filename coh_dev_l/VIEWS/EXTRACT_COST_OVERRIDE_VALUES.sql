--------------------------------------------------------
--  DDL for View EXTRACT_COST_OVERRIDE_VALUES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."EXTRACT_COST_OVERRIDE_VALUES" ("CLASS_ID", "CLASS_DESCRIPTION", "CATEGORY_ID", "CATEGORY_DESCRIPTION", "REHAB_REPLACEMENT", "LABOR", "EQUIPMENT_COST", "GENERAL_CONDITION_5_PERCENT", "CONTRACT_OH_N_PROFIT_15_PERCENT", "ENG_CM_ADMIN_LEGAL_20_PERCENT", "SUB_TOTAL", "CONTIGENCY_25_PERCENT", "TOTAL_COST") AS SELECT
        class_id,
        class_description,
        category_id,
        category_description,
        rehab_replacement,
        labor,
        equipment_cost,
        general_condition_5_percent,
        contract_oh_n_profit_15_percent,
        eng_cm_admin_legal_20_percent,
        sub_total,
        contigency_25_percent,
        total_cost
    FROM
        coh_dev_t.wwo_cost_override_master
    WHERE
        class_id IN (
            SELECT
                class_id
            FROM
                active_class
            WHERE
                active_flag = 'Y'
        )
;
