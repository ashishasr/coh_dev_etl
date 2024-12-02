--------------------------------------------------------
--  DDL for View EXTRACT_ASSET_TYPES_VALUES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."EXTRACT_ASSET_TYPES_VALUES" ("CLASS_ID", "CLASS_DESCRIPTION", "CATEGORY_ID", "CATEGORY_DESCRIPTION", "ESTIMATED_USEFUL_LIFE", "INITIAL_REINVESTMENT_ACTION", "MAX_NO_OF_REHABS", "REHAB_REVITALIZATION", "REHAB_EUL", "MAX_POTENTIAL_LIFE") AS SELECT
        class_id,
        class_description,
        category_id,
        category_description,
        estimated_useful_life,
        initial_reinvestment_action,
        max_no_of_rehabs,
        rehab_revitalization,
        rehab_eul,
        max_potential_life
    FROM
        coh_dev_t.wwo_asset_types_master
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
