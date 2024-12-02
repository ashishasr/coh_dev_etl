--------------------------------------------------------
--  DDL for Package Body PKG_LOAD_7_CMN_ASSET_BRR_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "COH_DEV_T"."PKG_LOAD_7_CMN_ASSET_BRR_INFO" AS

    FUNCTION get_brr_risk_baseline_value (
        in_lof_score                 NUMBER,
        in_cof_score                 NUMBER,
        in_redundancy_factor_revised NUMBER
    ) RETURN VARCHAR IS
        out_risk_baseline_value NUMBER;
    BEGIN
        SELECT
            round(round(in_lof_score, 2) * round(in_cof_score, 2) * round(in_redundancy_factor_revised, 2),2) AS result
        INTO out_risk_baseline_value
        FROM
            dual;

        RETURN out_risk_baseline_value;
    END;

    -----------------------
    FUNCTION get_brr_br1 (
        in_risk_baseline_value NUMBER
    ) RETURN VARCHAR IS
        out_brr_br1 VARCHAR(100);
    BEGIN
        SELECT
            CASE
                WHEN in_risk_baseline_value >= 20 THEN
                    'URGENT'
                WHEN in_risk_baseline_value < 20
                     AND in_risk_baseline_value >= 15 THEN
                    'PRIORITY'
                WHEN in_risk_baseline_value < 15
                     AND in_risk_baseline_value >= 10 THEN
                    'SHORT-TERM'
                WHEN in_risk_baseline_value < 10
                     AND in_risk_baseline_value >= 5 THEN
                    'MID-TERM'
                WHEN in_risk_baseline_value < 5
                     AND in_risk_baseline_value >= 0 THEN
                    'LONG-TERM'
                ELSE
                    '0'
            END
        INTO out_brr_br1
        FROM
            dual;

        RETURN out_brr_br1;
    END;
--------------------------------------
    FUNCTION get_brr_br2 (
        in_condition_score VARCHAR,
        in_br1             VARCHAR
    ) RETURN VARCHAR IS
        out_brr_br2 VARCHAR(100);
    BEGIN
        SELECT
            CASE
                WHEN in_condition_score = 5 THEN
                    'URGENT'
                ELSE
                    in_br1
            END
        INTO out_brr_br2
        FROM
            dual;

        RETURN out_brr_br2;
    END;
----------------------------------------

    FUNCTION get_brr_br3 (
        in_predicted_cip_year VARCHAR,
        in_br2                VARCHAR
    ) RETURN VARCHAR IS
        out_brr_br3 VARCHAR(100);
    BEGIN
        SELECT
            CASE
                WHEN in_predicted_cip_year = '0 to 3'
                     OR in_br2 = 'URGENT' THEN
                    'URGENT'
                WHEN in_predicted_cip_year = '3 to 5'
                     OR in_br2 = 'PRIORITY' THEN
                    'PRIORITY'
                WHEN in_predicted_cip_year = '5 to 10'
                     OR in_br2 = 'SHORT-TERM' THEN
                    'SHORT-TERM'
                WHEN in_predicted_cip_year = '10 to 20'
                     OR in_br2 = 'MID-TERM' THEN
                    'MID-TERM'
                WHEN in_predicted_cip_year = '>20'
                     OR in_br2 = 'LONG-TERM' THEN
                    'LONG-TERM'
                ELSE
                    ''
            END
        INTO out_brr_br3
        FROM
            dual;

        RETURN out_brr_br3;
    END;

    PROCEDURE proc_load_common_asset_cleaned_7_brr_info IS
    BEGIN
        execute immediate 'truncate table load_common_asset_cleaned_7_brr_info';

        COMMIT;
        INSERT INTO load_common_asset_cleaned_7_brr_info (
            asset_id,
            cof_score,
            condition_score,
            performance_score,
            redundancy_factor_revised,
            predicted_cip_year,
            lof_score
        )
            SELECT
                a.asset_id,
                a.cof_score,
                b.condition_score,
                c.performance_score,
                c.redundancy_factor_revised,
                d.predicted_cip_year,
                e.lof_score
            FROM
                     load_common_asset_cleaned_5_cof_info a
                INNER JOIN load_common_asset_cleaned_2_condition_q_info   b ON a.asset_id = b.asset_id
                INNER JOIN load_common_asset_cleaned_3_performance_info   c ON a.asset_id = c.asset_id
                INNER JOIN load_common_asset_cleaned_4_amc_info           d ON c.asset_id = d.asset_id
                INNER JOIN load_common_asset_cleaned_6_perf_cond_lof_info e ON d.asset_id = e.asset_id;

        COMMIT;
        UPDATE load_common_asset_cleaned_7_brr_info
        SET
            risk_baseline_value = pkg_load_7_cmn_asset_brr_info.get_brr_risk_baseline_value(lof_score, cof_score, redundancy_factor_revised
            );

        COMMIT;
        UPDATE load_common_asset_cleaned_7_brr_info
        SET
            br1 = pkg_load_7_cmn_asset_brr_info.get_brr_br1(risk_baseline_value);

        COMMIT;
        UPDATE load_common_asset_cleaned_7_brr_info
        SET
            br2 = pkg_load_7_cmn_asset_brr_info.get_brr_br2(condition_score, br1);

        COMMIT;
        UPDATE load_common_asset_cleaned_7_brr_info
        SET
            br3 = pkg_load_7_cmn_asset_brr_info.get_brr_br3(predicted_cip_year, br2);

        COMMIT;
    END;

    PROCEDURE start_data_refresh IS
    BEGIN
        proc_load_common_asset_cleaned_7_brr_info;
    END;

END pkg_load_7_cmn_asset_brr_info;

/
