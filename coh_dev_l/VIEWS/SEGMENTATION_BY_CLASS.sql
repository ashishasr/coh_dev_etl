--------------------------------------------------------
--  DDL for View SEGMENTATION_BY_CLASS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."SEGMENTATION_BY_CLASS" ("WWO_CLASS_ID", "WWO_CLASS_DESCRIPTION", "CLASS_TYPE", "UNQ_ASSET_DATA_UNIT", "UNQ_ASSET_COUNT", "COMMON_ASSET_DATA_UNIT", "COMMON_ASSET_COUNT", "DATA_UNIT", "TOTAL_ASSET_COUNT") AS WITH unq AS (
        SELECT
            trunc(data_unit) data_unit,
            data_unit        unq_asset_data_unit,
            class_type,
            COUNT(*)         unq_asset_count
        FROM
            unq_asset_parked
        GROUP BY
            data_unit,
            class_type
    ), c AS (
        SELECT
            trunc(data_unit) data_unit,
            data_unit        common_asset_data_unit,
            class_type,
            COUNT(*) / 2     common_asset_count
        FROM
            common_asset_parked
        GROUP BY
            data_unit,
            class_type
    )
    SELECT
        'NOT COUNTED'                                       wwo_class_id,
        'NOT COUNTED'                                       wwo_class_description,
        unq.class_type,
        unq.unq_asset_data_unit,
        unq.unq_asset_count,
        c.common_asset_data_unit,
        c.common_asset_count,
        unq.data_unit,
        unq.unq_asset_count + c.common_asset_count AS total_asset_count
    FROM
        unq,
        c
    WHERE
        unq.data_unit = c.data_unit
    UNION ALL
    SELECT
        NULL                        wwo_class_id,
        NULL                        wwo_class_description,
        null class_type,
        10.51                        unq_asset_data_unit,
        SUM(unq_eam_asset_count)    unq_asset_count,
        10.52                        common_asset_data_unit,
        SUM(common_eam_asset_count) common_asset_count,
        10.5                          data_unit,
        SUM(total_eam_asset_count)  asset_count
    FROM
        segmentation_all

    UNION ALL
    SELECT
        wwo_class_id,
        wwo_class_description,
        class_type,
        data_unit + 0.1        unq_asset_data_unit,
        unq_eam_asset_count    unq_asset_count,
        data_unit + 0.2        common_asset_data_unit,
        common_eam_asset_count common_asset_count,
        data_unit              data_unit,
        total_eam_asset_count  asset_count
    FROM
        segmentation_all ORDER BY
        unq_asset_data_unit
;
