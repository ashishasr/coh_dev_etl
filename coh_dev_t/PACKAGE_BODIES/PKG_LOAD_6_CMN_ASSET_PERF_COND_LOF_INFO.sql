--------------------------------------------------------
--  DDL for Package Body PKG_LOAD_6_CMN_ASSET_PERF_COND_LOF_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "COH_DEV_T"."PKG_LOAD_6_CMN_ASSET_PERF_COND_LOF_INFO" AS

    FUNCTION get_lof_score (
        in_condition_score   NUMBER,
        in_performance_score NUMBER
    ) RETURN VARCHAR IS
        out_lof_score NUMBER;
    BEGIN
        SELECT
            CASE
                WHEN in_condition_score IS NOT NULL
                     AND in_performance_score IS NOT NULL THEN
                    greatest(in_condition_score, in_performance_score)
                WHEN in_condition_score IS NOT NULL
                     AND in_performance_score IS NULL THEN
                    in_condition_score
                WHEN in_condition_score IS NULL
                     AND in_performance_score IS NOT NULL THEN
                    in_performance_score
                WHEN in_condition_score IS NULL THEN
                    NULL
                ELSE
                    0
            END
        INTO out_lof_score
        FROM
            dual;

        RETURN out_lof_score;
    END;

    FUNCTION get_lof_rating (
        in_lof_score VARCHAR
    ) RETURN VARCHAR IS
        out_lof_rating VARCHAR(100);
    BEGIN
        SELECT
            CASE
                WHEN in_lof_score = 5 THEN
                    'HIGH'
                WHEN in_lof_score = 4 THEN
                    'MEDIUM-HIGH'
                WHEN in_lof_score = 3 THEN
                    'MEDIUM'
                WHEN in_lof_score = 2 THEN
                    'MEDIUM-LOW'
                WHEN in_lof_score = 1 THEN
                    'LOW'
                ELSE
                    'Unknown'
            END
        INTO out_lof_rating
        FROM
            dual;

        RETURN out_lof_rating;
    END;

    PROCEDURE proc_load_common_asset_cleaned_perf_cond_lof_info IS
    BEGIN

    execute immediate 'truncate table LOAD_common_ASSET_CLEANED_6_PERF_COND_LOF_INFO';
    commit;

        INSERT INTO LOAD_common_ASSET_CLEANED_6_PERF_COND_LOF_INFO (
            asset_id,
            performance_score,
            condition_score
        )
            SELECT
                perf.asset_id,
                performance_score,
                condition_score
            FROM
                     LOAD_common_ASSET_CLEANED_2_CONDITION_Q_INFO cond
                INNER JOIN LOAD_common_ASSET_CLEANED_3_PERFORMANCE_INFO perf ON cond.asset_id = perf.asset_id;

        COMMIT;
        UPDATE LOAD_common_ASSET_CLEANED_6_PERF_COND_LOF_INFO
        SET
            lof_score = pkg_load_6_cmn_asset_perf_cond_lof_info.get_lof_score(condition_score, performance_score);

        COMMIT;
        UPDATE LOAD_common_ASSET_CLEANED_6_PERF_COND_LOF_INFO
        SET
            lof_rating = pkg_load_6_cmn_asset_perf_cond_lof_info.get_lof_rating(lof_score);

        COMMIT;
    END;

    PROCEDURE start_data_refresh IS
    BEGIN
        proc_load_common_asset_cleaned_perf_cond_lof_info;
    END;

END pkg_load_6_cmn_asset_perf_cond_lof_info;

/
