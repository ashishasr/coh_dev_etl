--------------------------------------------------------
--  DDL for Package Body PKG_LOAD_5_CMN_ASSET_COF_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "COH_DEV_T"."PKG_LOAD_5_CMN_ASSET_COF_INFO" AS

    FUNCTION get_cof_matrix_answers (
        in_matrix         VARCHAR,
        in_cof_matrix_key NUMBER
    ) RETURN VARCHAR IS
        out_cof_matrix_answer VARCHAR2(200);
    BEGIN
        SELECT
            matrix_answers
        INTO out_cof_matrix_answer
        FROM
            wwo_matrix_answers_master
        WHERE
                matrix = in_matrix
            AND matrix_key = in_cof_matrix_key;

        RETURN out_cof_matrix_answer;
    END;

    FUNCTION get_cof_score (
        in_replacement_cost  VARCHAR,
        in_om_impact         VARCHAR,
        in_level_of_service  VARCHAR,
        in_health_and_safety VARCHAR,
        in_permit_compliance VARCHAR,
        in_response_time     VARCHAR,
        in_service_priority  VARCHAR
    ) RETURN NUMBER IS
        out_get_cof_score NUMBER;
    BEGIN
        SELECT
            coalesce(round((greatest(TO_NUMBER(substr(in_replacement_cost, 1, 1)),
                                     TO_NUMBER(substr(in_om_impact, 1, 1))) + greatest(TO_NUMBER(substr(in_level_of_service, 1, 1)),
                                                                                       TO_NUMBER(substr(in_health_and_safety, 1, 1)))
                                                                                       + greatest(TO_NUMBER(substr(in_permit_compliance
                                                                                       , 1, 1)),
                                                                                                                                 TO_NUMBER
                                                                                                                                 (substr
                                                                                                                                 (in_response_time
                                                                                                                                 , 1,
                                                                                                                                 1)),
                                                                                                                                 TO_NUMBER
                                                                                                                                 (substr
                                                                                                                                 (in_service_priority
                                                                                                                                 , 1,
                                                                                                                                 1)))
                                                                                                                                 ) / 3
                                                                                                                                 ,
                           2),
                     0)
        INTO out_get_cof_score
        FROM
            dual;

        RETURN out_get_cof_score;
    END;

    FUNCTION get_cof_rating (
        in_cof_score NUMBER
    ) RETURN VARCHAR IS
        out_cof_rating VARCHAR(100);
    BEGIN
        SELECT
            CASE
                WHEN in_cof_score > 4 THEN
                    'HIGH'
                WHEN in_cof_score <= 4
                     AND in_cof_score > 3 THEN
                    'MEDIUM-HIGH'
                WHEN in_cof_score <= 3
                     AND in_cof_score > 2 THEN
                    'MEDIUM'
                WHEN in_cof_score <= 2
                     AND in_cof_score > 1 THEN
                    'MEDIUM-LOW'
                WHEN in_cof_score <= 1
                     AND in_cof_score >= 0 THEN
                    'LOW'
                ELSE
                    '0'
            END
        INTO out_cof_rating
        FROM
            dual;

        RETURN out_cof_rating;
    END;

    PROCEDURE proc_load_common_asset_cleaned_5_cof_info AS
    BEGIN
        execute immediate 'truncate table load_common_asset_cleaned_5_cof_info';

        COMMIT;
        INSERT INTO load_common_asset_cleaned_5_cof_info (
            asset_id,
            cof_replacement_cost,
            cof_om_impacts,
            cof_level_of_service,
            cof_health_and_safety,
            cof_permit_compliance,
            cof_response_time,
            cof_service_priority
        )
            SELECT
                a.asset_id,
                pkg_load_5_cmn_asset_cof_info.get_cof_matrix_answers('COF Replacement Cost', cof_replacement_cost),
                pkg_load_5_cmn_asset_cof_info.get_cof_matrix_answers('COF O&M Impact', cof_om_impacts),
                pkg_load_5_cmn_asset_cof_info.get_cof_matrix_answers('COF Level of Service', cof_level_of_service),
                pkg_load_5_cmn_asset_cof_info.get_cof_matrix_answers('COF Health and Safety', cof_health_and_safety),
                pkg_load_5_cmn_asset_cof_info.get_cof_matrix_answers('COF Permit Compliance', cof_permit_compliance),
                pkg_load_5_cmn_asset_cof_info.get_cof_matrix_answers('COF Response Time', cof_response_time),
                pkg_load_5_cmn_asset_cof_info.get_cof_matrix_answers('COF Service Priority', cof_service_priority)
            FROM
                     wwo_common_asset_cleaned_no_calc a
                INNER JOIN load_common_asset_cleaned_1_asset_info b ON a.asset_id = b.asset_id and reject_flag = 'N';

        COMMIT;
        UPDATE load_common_asset_cleaned_5_cof_info
        SET
            cof_score = pkg_load_5_cmn_asset_cof_info.get_cof_score(cof_replacement_cost, cof_om_impacts, cof_level_of_service, cof_health_and_safety
            , cof_permit_compliance,
                                                                cof_response_time, cof_service_priority);

        COMMIT;
        UPDATE load_common_asset_cleaned_5_cof_info
        SET
            cof_rating = pkg_load_5_cmn_asset_cof_info.get_cof_rating(cof_score);

        COMMIT;
    END;

    PROCEDURE start_data_refresh IS
    BEGIN
        proc_load_common_asset_cleaned_5_cof_info;
    END;

END pkg_load_5_cmn_asset_cof_info;

/
