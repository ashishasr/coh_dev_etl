--------------------------------------------------------
--  DDL for View TEMPLATE_COST_OVERRIDE_DU_9_10
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."TEMPLATE_COST_OVERRIDE_DU_9_10" ("CLASS_CODE_REVISED", "CLASS_DESCRIPTION_REVISED", "CATEGORY_CODE_REVISED", "CATEGORY_DESCRIPTION_REVISED", "REHAB_REPLACEMENT", "LABOR", "EQUIPMENT_COST", "GENERAL_CONDITION_5_PERCENT", "CONTRACT_OH_N_PROFIT_15_PERCENT", "ENG_CM_ADMIN_LEGAL_20_PERCENT", "SUB_TOTAL", "CONTIGENCY_25_PERCENT", "TOTAL_COST") AS SELECT
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
        extract_cost_override_du_9_10
;
