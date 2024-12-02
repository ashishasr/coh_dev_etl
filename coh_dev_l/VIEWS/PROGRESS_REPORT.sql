--------------------------------------------------------
--  DDL for View PROGRESS_REPORT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."PROGRESS_REPORT" ("CLASS", "UNQ_DATA_UNIT", "UNQ_COUNT", "UNQ_COMPLETION_PERCENTAGE", "UNQ_STATUS", "COMMON_DATA_UNIT", "COMMON_COUNT", "COMMON_COMPLETION_PERCENTAGE", "COMMON_STATUS", "DATA_UNIT", "TOTAL_COUNT", "TOTAL_COMPLETION_PERCENTAGE", "TOTAL_STATUS") AS SELECT
        class_type,
        unq_asset_data_unit,
        unq_eam_asset_count,
        round((unq_eam_asset_count / SUM(asset_count)
                                     OVER()) * 100,
              2) || '%' AS unq_completion_percentage,
              null,
        common_asset_data_unit,
        common_eam_asset_count,
        round((common_eam_asset_count / SUM(asset_count)
                                        OVER()) * 100,
              2) || '%' AS common_completion_percentage,
              null,
        data_unit,
        asset_count,
        round((asset_count / SUM(asset_count)
                             OVER()) * 100,
              2)|| '%' AS total_completion_percentage,
              null
    FROM
        workable_du
    ORDER BY
        unq_asset_data_unit
;
