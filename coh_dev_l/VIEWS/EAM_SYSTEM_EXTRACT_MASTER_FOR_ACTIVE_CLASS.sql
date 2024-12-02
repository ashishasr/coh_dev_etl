--------------------------------------------------------
--  DDL for View EAM_SYSTEM_EXTRACT_MASTER_FOR_ACTIVE_CLASS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."EAM_SYSTEM_EXTRACT_MASTER_FOR_ACTIVE_CLASS" ("ASSET_ID", "CLASS_ID", "STATUS", "COMMISSION_DATE") AS SELECT
        asset_id,
        class_id,
        status,
        commission_date
    FROM
        coh_dev_t.wwo_eam_system_extract_master
    WHERE
        asset_id IN (
            SELECT
                asset_id
            FROM
                unq_asset_cleaned_no_calc_by_active_class
        )
;
