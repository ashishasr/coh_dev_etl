--------------------------------------------------------
--  DDL for View TEMPLATE_ASSET_TYPES_DU_9_10
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."TEMPLATE_ASSET_TYPES_DU_9_10" ("CLASS_ID", "CLASS_DESCRIPTION", "CATEGORY_ID", "CATEGORY_DESCRIPTION", "ESTIMATED_USEFUL_LIFE", "INITIAL_REINVESTMENT_ACTION", "MAX_NO_OF_REHABS", "REHAB_REVITALIZATION", "REHAB_EUL", "MAX_POTENTIAL_LIFE") AS SELECT DISTINCT
        a.class_id,
        a.class_description,
        a.category_id,
        a.category_description,
        a.estimated_useful_life,
        NULL initial_reinvestment_action,
        a.max_no_of_rehabs,
        a.rehab_revitalization,
        NULL rehab_eul,
        NULL max_potential_life
    FROM
             extract_asset_types_values_du_9_10 a
        INNER JOIN extract_asset_register_du_9_10 b ON a.class_id = b.class_id
                                                       AND a.category_id = b.category_id
;
