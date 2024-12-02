--------------------------------------------------------
--  DDL for Package Body PKG_LOAD_2_CMN_ASSET_CONDITION_Q_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "COH_DEV_T"."PKG_LOAD_2_CMN_ASSET_CONDITION_Q_INFO" AS

    FUNCTION get_condition_score (
        in_condition_a1  NUMBER,
        in_condition_a2  NUMBER,
        in_condition_a3  NUMBER,
        in_condition_a4  NUMBER,
        in_condition_a5  NUMBER,
        in_condition_a6  NUMBER,
        in_condition_a7  NUMBER,
        in_condition_a8  NUMBER,
        in_condition_a9  NUMBER,
        in_condition_a10 NUMBER
    ) RETURN NUMBER IS
        out_condition_score NUMBER;
    BEGIN
        SELECT
            greatest(in_condition_a1, in_condition_a2, in_condition_a3, in_condition_a4, in_condition_a5,
                     in_condition_a6, in_condition_a7, in_condition_a8, in_condition_a9, in_condition_a10)
        INTO out_condition_score
        FROM
            dual;

        RETURN out_condition_score;
    END;
---------------------------------------------------------------------------------------
    FUNCTION get_condition_rating (
        in_condition_score NUMBER
    ) RETURN VARCHAR IS
        out_condition_rating VARCHAR(100);
    BEGIN
        SELECT
            CASE
                WHEN in_condition_score = 5 THEN
                    'Very Poor'
                WHEN in_condition_score = 4 THEN
                    'Poor'
                WHEN in_condition_score = 3 THEN
                    'Moderate'
                WHEN in_condition_score = 2 THEN
                    'Good'
                WHEN in_condition_score = 1 THEN
                    'Excellent'
                ELSE
                    'Very Poor'
            END
        INTO out_condition_rating
        FROM
            dual;

        RETURN out_condition_rating;
    END;
------------------------------------------------------------------------------------------
    PROCEDURE proc_load_common_asset_cleaned_2_condition_q_info AS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table load_common_asset_cleaned_2_condition_q_info';
        COMMIT;
        INSERT INTO load_common_asset_cleaned_2_condition_q_info (
            asset_id,
            class_id,
            class_description
        )
            SELECT
                asset_id,
                class_id,
                class_description
            FROM
                load_common_asset_cleaned_1_asset_info;

        COMMIT;
    ------------------------    
        MERGE INTO load_common_asset_cleaned_2_condition_q_info x
        --USING WWO_CONDITION_SET_Q_MASTER mst ON ( x.class_id = mst.class_id )
        USING wwo_common_asset_cleaned_no_calc_condition_q_t mst ON (  x.asset_id = mst.asset_id)
        WHEN MATCHED THEN UPDATE
        SET x.condition_q1 = mst.condition_q1,
            x.condition_q2 = mst.condition_q2,
            x.condition_q3 = mst.condition_q3,
            x.condition_q4 = mst.condition_q4,
            x.condition_q5 = mst.condition_q5,
            x.condition_q6 = mst.condition_q6,
            x.condition_q7 = mst.condition_q7,
            x.condition_q8 = mst.condition_q8,
            x.condition_q9 = mst.condition_q9,
            x.condition_q10 = mst.condition_q10;

        COMMIT;
        MERGE INTO load_common_asset_cleaned_2_condition_q_info x
        --USING wwo_common_asset_cleaned_no_calc mst ON ( x.asset_id = mst.asset_id )
        USING (Select * from wwo_common_asset_cleaned_no_calc where  reject_flag = 'N') mst ON ( x.asset_id = mst.asset_id)
        WHEN MATCHED THEN UPDATE
        SET x.condition_a1 = mst.condition_a1,
            x.condition_a2 = mst.condition_a2,
            x.condition_a3 = mst.condition_a3,
            x.condition_a4 = mst.condition_a4,
            x.condition_a5 = mst.condition_a5,
            x.condition_a6 = mst.condition_a6,
            x.condition_a7 = mst.condition_a7,
            x.condition_a8 = mst.condition_a8,
            x.condition_a9 = mst.condition_a9,
            x.condition_a10 = mst.condition_a10;

        COMMIT;
        UPDATE load_common_asset_cleaned_2_condition_q_info
        SET
            condition_score = pkg_load_2_cmn_asset_condition_q_info.get_condition_score(condition_a1, condition_a2, condition_a3, condition_a4
            , condition_a5,
                                                                                    condition_a6, condition_a7, condition_a8, condition_a9
                                                                                    , condition_a10);

        COMMIT;
        UPDATE load_common_asset_cleaned_2_condition_q_info
        SET
            condition_rating = pkg_load_2_cmn_asset_condition_q_info.get_condition_rating(condition_score);

        COMMIT;
    END;

    PROCEDURE start_data_refresh IS
    BEGIN
        proc_load_common_asset_cleaned_2_condition_q_info;
    END;

END pkg_load_2_cmn_asset_condition_q_info;

/
