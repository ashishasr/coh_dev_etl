--------------------------------------------------------
--  DDL for View TEMPLATE_COMMON_ASSET_TYPES_DU_9_10
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."TEMPLATE_COMMON_ASSET_TYPES_DU_9_10" ("CLASS_ID", "CLASS_DESCRIPTION", "CATEGORY_ID", "CATEGORY_DESCRIPTION", "ESTIMATED_USEFUL_LIFE", "INITIAL_REINVESTMENT_ACTION", "MAX_NO_OF_REHABS", "REHAB_REVITALIZATION", "REHAB_EUL", "MAX_POTENTIAL_LIFE") AS SELECT
        class_id,
        class_description,
        category_id,
        category_description,
        estimated_useful_life,
        NULL initial_reinvestment_action,
        max_no_of_rehabs,
        rehab_revitalization,
        NULL rehab_eul,
        NULL max_potential_life
    FROM
        extract_common_asset_types_values_du_9_10
;
