--------------------------------------------------------
--  DDL for View TEMPLATE_COMMON_COST_OVERRIDE_DU_11
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."TEMPLATE_COMMON_COST_OVERRIDE_DU_11" ("CLASS_CODE_REVISED", "CLASS_DESCRIPTION_REVISED", "CATEGORY_CODE_REVISED", "CATEGORY_DESCRIPTION_REVISED", "REHAB_REPLACEMENT", "LABOR", "EQUIPMENT_COST", "GENERAL_CONDITION_5_PERCENT", "CONTRACT_OH_N_PROFIT_15_PERCENT", "ENG_CM_ADMIN_LEGAL_20_PERCENT", "SUB_TOTAL", "CONTIGENCY_25_PERCENT", "TOTAL_COST") AS SELECT
        class_id,
        class_description,
        category_id,
        category_description,
        rehab_replacement,
        labor,
        equipment_cost,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL
    FROM
        extract_common_cost_override_du_11
;
