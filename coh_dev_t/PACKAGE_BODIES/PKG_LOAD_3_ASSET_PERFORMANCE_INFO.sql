--------------------------------------------------------
--  DDL for Package Body PKG_LOAD_3_ASSET_PERFORMANCE_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "COH_DEV_T"."PKG_LOAD_3_ASSET_PERFORMANCE_INFO" AS

    FUNCTION get_performace_matrix_answers (
        in_matrix                 VARCHAR,
        in_performance_matrix_key NUMBER
    ) RETURN VARCHAR IS
        out_performance_matrix_answer VARCHAR2(200);
    BEGIN
        SELECT
            matrix_answers
        INTO out_performance_matrix_answer
        FROM
            wwo_matrix_answers_master
        WHERE
                matrix = in_matrix
            AND matrix_key = in_performance_matrix_key;

        RETURN out_performance_matrix_answer;
    END;

    FUNCTION get_performance_score (
        in_capacity     VARCHAR,
        in_reliability  VARCHAR,
        in_o_m          VARCHAR,
        in_obsolescence VARCHAR,
        in_redundancy   VARCHAR
    ) RETURN NUMBER IS
        out_performance_score NUMBER;
    BEGIN
        SELECT
            nvl(greatest(TO_NUMBER(substr(in_capacity, 1, 1)),
                         TO_NUMBER(substr(in_reliability, 1, 1)),
                         TO_NUMBER(substr(in_o_m, 1, 1)),
                         TO_NUMBER(substr(in_obsolescence, 1, 1)),
                         TO_NUMBER(substr(in_redundancy, 1, 1))),
                0)
        INTO out_performance_score
        FROM
            dual;

        RETURN out_performance_score;
    END;

    FUNCTION get_performance_rating (
        in_performance_score NUMBER
    ) RETURN VARCHAR IS
        out_performance_rating VARCHAR(100);
    BEGIN
        SELECT
            CASE
                WHEN in_performance_score = 5 THEN
                    'Very Poor'
                WHEN in_performance_score = 4 THEN
                    'Poor'
                WHEN in_performance_score = 3 THEN
                    'Moderate'
                WHEN in_performance_score = 2 THEN
                    'Good'
                WHEN in_performance_score = 1 THEN
                    'Excellent'
                ELSE
                    'Unknown'
            END
        INTO out_performance_rating
        FROM
            dual;

        RETURN out_performance_rating;
    END;

    FUNCTION get_redundancy_factor_revised (
        in_redundancy VARCHAR
    ) RETURN NUMBER IS
        out_redundancy_factor_revised NUMBER;
    BEGIN
        SELECT
            CASE
                WHEN in_redundancy = '5 - No Redundancy'                  THEN
                    1
                WHEN in_redundancy = '4 - Spares on Hand'                 THEN
                    0.9
                WHEN in_redundancy = '3 - Manually Operated Redundancy'   THEN
                    0.8
                WHEN in_redundancy = '2 - Partially Automated Redundancy' THEN
                    0.75
                WHEN in_redundancy = '1 - Fully Automated Redundancy'     THEN
                    0.6
                WHEN in_redundancy = '0 - Unknown / N/A'                  THEN
                    1
                WHEN in_redundancy IS NULL THEN
                    1  -- Handles the case where Redundancy is empty
                ELSE
                    1  -- Default case, if none of the above conditions are met
            END
        INTO out_redundancy_factor_revised
        FROM
            dual;

        RETURN out_redundancy_factor_revised;
    END;

    PROCEDURE proc_load_unq_asset_cleaned_3_performance_info AS
    BEGIN
        execute immediate 'truncate table load_unq_asset_cleaned_3_performance_info';

        COMMIT;
        INSERT INTO load_unq_asset_cleaned_3_performance_info (
            asset_id,
            performance_capacity,
            performance_reliability,
            performance_om,
            performance_obsolescence,
            performance_redundancy
        )
            SELECT
                a.asset_id,
                pkg_load_3_asset_performance_info.get_performace_matrix_answers('Performance Capacity', performance_capacity),
                pkg_load_3_asset_performance_info.get_performace_matrix_answers('Performance Reliability', performance_reliability),
                pkg_load_3_asset_performance_info.get_performace_matrix_answers('Performance OM', performance_om),
                pkg_load_3_asset_performance_info.get_performace_matrix_answers('Performance Obsolescence', performance_obsolescence),
                pkg_load_3_asset_performance_info.get_performace_matrix_answers('Performance Redundancy', performance_redundancy)
            FROM
                     wwo_unq_asset_cleaned_no_calc a
                INNER JOIN load_unq_asset_cleaned_1_asset_info b ON a.asset_id = b.asset_id;

        COMMIT;
        UPDATE load_unq_asset_cleaned_3_performance_info
        SET
            performance_score = pkg_load_3_asset_performance_info.get_performance_score(performance_capacity, performance_reliability, performance_om
            , performance_obsolescence, performance_redundancy);

        COMMIT;
        UPDATE load_unq_asset_cleaned_3_performance_info
        SET
            performance_rating = pkg_load_3_asset_performance_info.get_performance_rating(performance_score);

        COMMIT;
        UPDATE load_unq_asset_cleaned_3_performance_info
        SET
            redundancy_factor_revised = pkg_load_3_asset_performance_info.get_redundancy_factor_revised(performance_redundancy);

        COMMIT;
    END;

    PROCEDURE start_data_refresh IS
    BEGIN
        proc_load_unq_asset_cleaned_3_performance_info;
    END;

END pkg_load_3_asset_performance_info;

/
