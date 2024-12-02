--------------------------------------------------------
--  DDL for View T_IN_WWO_COST_OVERRIDE_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_T"."T_IN_WWO_COST_OVERRIDE_V" ("CLASS_ID", "CLASS_DESCRIPTION", "CATEGORY_ID", "CATEGORY_DESCRIPTION", "REHAB_REPLACEMENT", "LABOR", "EQUIPMENT_COST", "DT_INSERTED") AS SELECT
        class_id,
        class_description,
        category_id,
        category_description,
        rehab_replacement,
        labor,
        equipment_cost,
        dt_inserted
    FROM
        coh_dev_e.e_wwo_cost_override_v
;
