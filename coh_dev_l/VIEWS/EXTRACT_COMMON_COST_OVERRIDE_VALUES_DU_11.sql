--------------------------------------------------------
--  DDL for View EXTRACT_COMMON_COST_OVERRIDE_VALUES_DU_11
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."EXTRACT_COMMON_COST_OVERRIDE_VALUES_DU_11" ("CLASS_ID", "CLASS_DESCRIPTION", "CATEGORY_ID", "CATEGORY_DESCRIPTION", "REHAB_REPLACEMENT", "LABOR", "EQUIPMENT_COST", "GENERAL_CONDITION_5_PERCENT", "CONTRACT_OH_N_PROFIT_15_PERCENT", "ENG_CM_ADMIN_LEGAL_20_PERCENT", "SUB_TOTAL", "CONTIGENCY_25_PERCENT", "TOTAL_COST") AS SELECT DISTINCT
        a.class_id,
        a.class_description,
        a.category_id,
        a.category_description,
        a.rehab_replacement,
        a.labor,
        a.equipment_cost,
        a.general_condition_5_percent,
        a.contract_oh_n_profit_15_percent,
        a.eng_cm_admin_legal_20_percent,
        a.sub_total,
        a.contigency_25_percent,
        a.total_cost
    FROM
             coh_dev_t.wwo_cost_override_master a
        INNER JOIN extract_common_asset_register_du_11 b ON a.class_id = b.class_id
                                                     AND a.category_id = b.category_id
;
