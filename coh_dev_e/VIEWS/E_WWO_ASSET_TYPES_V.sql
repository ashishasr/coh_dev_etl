--------------------------------------------------------
--  DDL for View E_WWO_ASSET_TYPES_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_E"."E_WWO_ASSET_TYPES_V" ("CLASS_ID", "CLASS_DESCRIPTION", "CATEGORY_ID", "CATEGORY_DESCRIPTION", "ESTIMATED_USEFUL_LIFE", "MAX_NO_OF_REHABS", "REHAB_REVITALIZATION", "DT_INSERTED") AS SELECT
        TRIM(class_id),
        TRIM(class_description),
        TRIM(category_id),
        TRIM(category_description),
        TRIM(estimated_useful_life),
        TRIM(max_no_of_rehabs),
        TRIM(rehab_revitalization),
        dt_inserted
    FROM
        e_wwo_asset_types
;
  GRANT READ ON "COH_DEV_E"."E_WWO_ASSET_TYPES_V" TO "COH_DEV_T" WITH GRANT OPTION;
