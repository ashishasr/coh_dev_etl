--------------------------------------------------------
--  DDL for View WORKABLE_DU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."WORKABLE_DU" ("CLASS_TYPE", "UNQ_ASSET_DATA_UNIT", "UNQ_EAM_ASSET_COUNT", "COMMON_ASSET_DATA_UNIT", "COMMON_EAM_ASSET_COUNT", "DATA_UNIT", "ASSET_COUNT") AS SELECT
        class_type,
        data_unit + 0.1             unq_asset_data_unit,
        SUM(unq_eam_asset_count)    unq_eam_asset_count,
        data_unit + 0.2             common_asset_data_unit,
        SUM(common_eam_asset_count) common_eam_asset_count,
        data_unit,
        SUM(unq_eam_asset_count) + SUM(common_eam_asset_count)
    FROM
        coh_dev_t.t_out_all_asset_class_segmentation
    GROUP BY
        data_unit,
        class_type
;
