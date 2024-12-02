--------------------------------------------------------
--  DDL for View UNQ_ASSET_CONDITION_Q_DISCREPENCY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."UNQ_ASSET_CONDITION_Q_DISCREPENCY" ("DATA_UNIT", "CLASS_ID", "CLASS_DESCRIPTION", "TOTAL_ASSET", "ASSETS_DISCREPENCY_IN_CONDITION_Q", "PERCENTAGE_DISCREPENCY") AS WITH a AS (
        SELECT
            eam_class_id,
            eam_class_description,
            COUNT(*) assets_discrepency
        FROM
            unq_asset_cleaned_no_calc
        WHERE
            eam_class_id <> raw_class_id
        GROUP BY
            eam_class_id,
            eam_class_description
        ORDER BY
            eam_class_description
    ), b AS (
        SELECT
            eam_class_id,
            eam_class_description,
            COUNT(*) total_asset
        FROM
            unq_asset_cleaned_no_calc
        GROUP BY
            eam_class_id,
            eam_class_description
        ORDER BY
            eam_class_description
    )
    SELECT
        c.unq_asset_data_unit,
        a.eam_class_id,
        a.eam_class_description,
        total_asset,
        assets_discrepency,
        CASE
            WHEN total_asset = assets_discrepency THEN
                '100%'
            ELSE
                to_char(round((( assets_discrepency) / total_asset) * 100, 2))
                || '%'
        END percentage
    FROM
             a
        INNER JOIN b ON a.eam_class_id = b.eam_class_id
        INNER JOIN segmentation_by_class c ON a.eam_class_id = c.wwo_class_id
    ORDER BY
        c.unq_asset_data_unit,
        a.eam_class_description
;
