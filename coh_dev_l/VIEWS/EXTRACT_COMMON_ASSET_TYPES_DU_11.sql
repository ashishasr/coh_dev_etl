--------------------------------------------------------
--  DDL for View EXTRACT_COMMON_ASSET_TYPES_DU_11
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."EXTRACT_COMMON_ASSET_TYPES_DU_11" ("CLASS_ID", "CLASS_DESCRIPTION", "CATEGORY_ID", "CATEGORY_DESCRIPTION", "ESTIMATED_USEFUL_LIFE", "INITIAL_REINVESTMENT_ACTION", "MAX_NO_OF_REHABS", "REHAB_REVITALIZATION", "REHAB_EUL", "MAX_POTENTIAL_LIFE") AS SELECT DISTINCT
        a.class_id,
        a.class_description,
        a.category_id,
        a.category_description,
        a.estimated_useful_life,
        a.initial_reinvestment_action,
        a.max_no_of_rehabs,
        --TO_CHAR(rehab_revitalization, 'FM0%')rehab_revitalization, 
        a.rehab_revitalization || '%',
        a.rehab_eul,
        a.max_potential_life
    FROM
             coh_dev_t.wwo_asset_types_master a
        INNER JOIN extract_common_asset_register_du_11 b ON a.class_id = b.class_id
                                                     AND a.category_id = b.category_id
;
