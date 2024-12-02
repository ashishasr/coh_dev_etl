--------------------------------------------------------
--  DDL for View T_IN_WWO_ASSET_TYPES_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_T"."T_IN_WWO_ASSET_TYPES_V" ("CLASS_ID", "CLASS_DESCRIPTION", "CATEGORY_ID", "CATEGORY_DESCRIPTION", "ESTIMATED_USEFUL_LIFE", "MAX_NO_OF_REHABS", "REHAB_REVITALIZATION", "DT_INSERTED") AS SELECT
        class_id,
        class_description,
        category_id,
        category_description,
        estimated_useful_life,
        max_no_of_rehabs,
        rehab_revitalization,
        dt_inserted
    FROM
        coh_dev_e.e_wwo_asset_types_v
;
