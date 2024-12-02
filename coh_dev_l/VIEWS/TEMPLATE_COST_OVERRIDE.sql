--------------------------------------------------------
--  DDL for View TEMPLATE_COST_OVERRIDE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."TEMPLATE_COST_OVERRIDE" ("CLASS_CODE_REVISED", "CLASS_DESCRIPTION_REVISED", "CATEGORY_CODE_REVISED", "CATEGORY_DESCRIPTION_REVISED", "REHAB_REPLACEMENT", "LABOR", "EQUIPMENT_COST", "GENERAL_CONDITION_5_PERCENT", "CONTRACT_OH_N_PROFIT_15_PERCENT", "ENG_CM_ADMIN_LEGAL_20_PERCENT", "SUB_TOTAL", "CONTIGENCY_25_PERCENT", "TOTAL_COST") AS SELECT
        class_id,
        class_description,
        category_id,
        category_description,
        rehab_replacement,
        labor,
        equipment_cost,
        null,
        null,
        null,
        null,
        null,
        null
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
