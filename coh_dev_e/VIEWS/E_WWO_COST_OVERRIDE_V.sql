--------------------------------------------------------
--  DDL for View E_WWO_COST_OVERRIDE_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_E"."E_WWO_COST_OVERRIDE_V" ("CLASS_ID", "CLASS_DESCRIPTION", "CATEGORY_ID", "CATEGORY_DESCRIPTION", "REHAB_REPLACEMENT", "LABOR", "EQUIPMENT_COST", "DT_INSERTED") AS SELECT
        TRIM(class_id),
        TRIM(class_description),
        TRIM(category_id),
        TRIM(category_description),
        TRIM(rehab_replacement),
        TRIM(labor),
        TRIM(equipment_cost),
        dt_inserted
    FROM
        e_wwo_cost_override
;
  GRANT READ ON "COH_DEV_E"."E_WWO_COST_OVERRIDE_V" TO "COH_DEV_T" WITH GRANT OPTION;
