--------------------------------------------------------
--  DDL for View SEGMENTATION_ALL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."SEGMENTATION_ALL" ("DATA_UNIT", "CLASS_TYPE", "WWO_CLASS_ID", "WWO_CLASS_DESCRIPTION", "UNQ_RAW_ASSET_COUNT", "UNQ_EAM_ASSET_COUNT", "COMMON_RAW_ASSET_COUNT", "COMMON_EAM_ASSET_COUNT", "TOTAL_RAW_ASSET_COUNT", "TOTAL_EAM_ASSET_COUNT") AS SELECT
        data_unit,
        class_type,
        wwo_class_id,
        wwo_class_description,
        unq_raw_asset_count,
        unq_eam_asset_count,
        common_raw_asset_count,
        common_eam_asset_count,
        total_raw_asset_count,
        total_eam_asset_count
    FROM
        coh_dev_t.t_out_all_asset_class_segmentation
;
