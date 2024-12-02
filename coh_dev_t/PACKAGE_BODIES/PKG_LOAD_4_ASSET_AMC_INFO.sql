--------------------------------------------------------
--  DDL for Package Body PKG_LOAD_4_ASSET_AMC_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "COH_DEV_T"."PKG_LOAD_4_ASSET_AMC_INFO" AS

    FUNCTION get_amc_age (
        in_min_system_commission_year NUMBER
    ) RETURN NUMBER IS
        out_amc_age NUMBER;
    BEGIN
        SELECT
            EXTRACT(YEAR FROM sysdate) - in_min_system_commission_year
        INTO out_amc_age
        FROM
            dual;

        RETURN out_amc_age;
    END;
---------------------------------------------
    FUNCTION get_amc_life_remaining (
        in_estimated_useful_life NUMBER,
        in_age                   NUMBER
    ) RETURN NUMBER IS
        out_get_life_remaining NUMBER;
    BEGIN
        SELECT
            CASE
                WHEN ( in_estimated_useful_life - in_age ) >= 0 THEN
                    ( in_estimated_useful_life - in_age )
                ELSE
                    0
            END
        INTO out_get_life_remaining
        FROM
            dual;

        RETURN out_get_life_remaining;
    END;
-------------------------------------------------
    FUNCTION get_amc_percent_life_consumed_number (
        in_estimated_useful_life NUMBER,
        in_life_remaining        NUMBER
    ) RETURN NUMBER IS
        out_percent_life_consumed NUMBER;
    BEGIN
        SELECT
            CASE
                WHEN in_estimated_useful_life IS NULL
                     OR in_estimated_useful_life = 0 THEN
                    0
                ELSE
                  round(  ((in_estimated_useful_life - in_life_remaining)  / in_estimated_useful_life) , 2)-- added round 19th nov
            END
        INTO out_percent_life_consumed
        FROM
            dual;

        RETURN out_percent_life_consumed;
    END;
--------------------------------------------------

    FUNCTION get_amc_condition_adjusted_useful_life (
        in_condition_score       NUMBER,
        in_percent_life_consumed_number NUMBER,
        in_estimated_useful_life NUMBER,
        in_age                   NUMBER
    ) RETURN NUMBER IS
        out_condition_adjusted_useful_life NUMBER;
    BEGIN
        SELECT
            ceil(
                CASE
                    WHEN in_condition_score = 1
                         AND in_percent_life_consumed_number < 0.2 THEN
                        in_estimated_useful_life
                    WHEN in_condition_score = 1
                         AND in_percent_life_consumed_number >= 0.2 THEN
                        in_age +(0.8 * in_estimated_useful_life)
                    WHEN in_condition_score = 2
                         AND in_percent_life_consumed_number < 0.5 THEN
                        in_estimated_useful_life
                    WHEN in_condition_score = 2
                         AND in_percent_life_consumed_number >= 0.5 THEN
                        in_age +(0.6 * in_estimated_useful_life)
                    WHEN in_condition_score = 3
                         AND in_percent_life_consumed_number < 0.2 THEN
                        0.6 * in_estimated_useful_life
                    WHEN in_condition_score = 3
                         AND in_percent_life_consumed_number >= 0.2
                         AND in_percent_life_consumed_number < 0.5 THEN
                        0.8 * in_estimated_useful_life
                    WHEN in_condition_score = 3
                         AND in_percent_life_consumed_number >= 0.5
                         AND in_percent_life_consumed_number < 0.8 THEN
                        in_estimated_useful_life
                    WHEN in_condition_score = 3
                         AND in_percent_life_consumed_number >= 0.8
                         AND in_percent_life_consumed_number < 1 THEN
                        in_age +(0.3 * in_estimated_useful_life)
                    WHEN in_condition_score = 3
                         AND in_percent_life_consumed_number >= 1
                         AND in_percent_life_consumed_number < 2 THEN
                        1.2 * in_estimated_useful_life
                    WHEN in_condition_score = 4
                         AND in_percent_life_consumed_number < 0.2 THEN
                        0.4 * in_estimated_useful_life
                    WHEN in_condition_score = 4
                         AND in_percent_life_consumed_number >= 0.2
                         AND in_percent_life_consumed_number < 0.5 THEN
                        0.5 * in_estimated_useful_life
                    WHEN in_condition_score = 4
                         AND in_percent_life_consumed_number >= 0.5
                         AND in_percent_life_consumed_number < 0.8 THEN
                        0.8 * in_estimated_useful_life
                    WHEN in_condition_score = 4
                         AND in_percent_life_consumed_number >= 0.8
                         AND in_percent_life_consumed_number < 1 THEN
                        in_estimated_useful_life
                    WHEN in_condition_score = 4
                         AND in_percent_life_consumed_number >= 1
                         AND in_percent_life_consumed_number < 2 THEN
                        in_estimated_useful_life
                    WHEN in_condition_score = 5 THEN
                        in_age
                    ELSE
                        in_estimated_useful_life
                END
            )
        INTO out_condition_adjusted_useful_life
        FROM
            dual;

        RETURN out_condition_adjusted_useful_life;
    END;

--------------------------------------------
    FUNCTION get_amc_condition_adjusted_life_remaining (
        in_condition_adjusted_useful_life NUMBER,
        in_age                            NUMBER
    ) RETURN NUMBER IS
        out_ca_life_remaining VARCHAR(100);
    BEGIN
        SELECT
            CASE
                WHEN in_condition_adjusted_useful_life - in_age >= 0 THEN
                    in_condition_adjusted_useful_life - in_age
                ELSE
                    0
            END
        INTO out_ca_life_remaining
        FROM
            dual;

        RETURN out_ca_life_remaining;
    END;

--------------------------------------------
    FUNCTION get_amc_condition_adjusted_percent_life_consumed_number (
        in_estimated_useful_life             NUMBER,
        in_condition_adjusted_life_remaining NUMBER
    ) RETURN NUMBER IS
        out_condition_adjusted_percent_life_consumed NUMBER;
    BEGIN
        SELECT
            CASE
                WHEN in_estimated_useful_life IS NULL
                     OR in_estimated_useful_life = 0 THEN
                    0
                ELSE
                    round(  (( in_estimated_useful_life - in_condition_adjusted_life_remaining ) / in_estimated_useful_life) , 2)-- added round 19th nov
            END
        INTO out_condition_adjusted_percent_life_consumed
        FROM
            dual;

        RETURN out_condition_adjusted_percent_life_consumed;
    END;

-------------------------------------------
    FUNCTION get_amc_predicted_replacement_year (
        in_condition_adjusted_life_remaining NUMBER
    ) RETURN NUMBER IS
        out_predicted_replacement_year NUMBER;
    BEGIN
        SELECT
            EXTRACT(YEAR FROM sysdate) + in_condition_adjusted_life_remaining
        INTO out_predicted_replacement_year
        FROM
            dual;

        RETURN out_predicted_replacement_year;
    END;

-------------------------------------------
    FUNCTION get_amc_predicted_cip_year (
        in_condition_adjusted_life_remaining NUMBER
    ) RETURN VARCHAR IS
        out_get_predicted_cip_year VARCHAR(10);
    BEGIN
        SELECT
            CASE
                WHEN in_condition_adjusted_life_remaining IS NULL
                     OR in_condition_adjusted_life_remaining = '' THEN
                    ''
                WHEN in_condition_adjusted_life_remaining <= 3 THEN
                    '0 to 3'
                WHEN in_condition_adjusted_life_remaining > 3
                     AND in_condition_adjusted_life_remaining <= 5 THEN
                    '3 to 5'
                WHEN in_condition_adjusted_life_remaining > 5
                     AND in_condition_adjusted_life_remaining <= 10 THEN
                    '5 to 10'
                WHEN in_condition_adjusted_life_remaining > 10
                     AND in_condition_adjusted_life_remaining <= 20 THEN
                    '10 to 20'
                ELSE
                    '>20'
            END
        INTO out_get_predicted_cip_year
        FROM
            dual;

        RETURN out_get_predicted_cip_year;
    END;

------------------------------------------
    PROCEDURE proc_load_unq_asset_cleaned_4_amc_info IS
    BEGIN
        execute immediate 'truncate table load_unq_asset_cleaned_4_amc_info';

        COMMIT;
        INSERT INTO load_unq_asset_cleaned_4_amc_info (
            asset_id,
            class_id,
            class_description,
            category_id,
            category_description,
            min_system_commission_year,
            estimated_useful_life,
            max_no_of_rehabs,
            rehab_revitalization_percent,
            condition_score
        )
            SELECT
                a.asset_id,
                a.class_id,
                a.class_description,
                a.category_id,
                a.category_description,
                a.min_system_commission_year,
                a.estimated_useful_life,
                a.max_no_of_rehabs,
                a.rehab_revitalization_percent,
                b.condition_score
            FROM
                     load_unq_asset_cleaned_1_asset_info a
                LEFT JOIN load_unq_asset_cleaned_2_condition_q_info b ON a.asset_id = b.asset_id;

        COMMIT;
        UPDATE load_unq_asset_cleaned_4_amc_info
        SET
            age = pkg_load_4_asset_amc_info.get_amc_age(min_system_commission_year);

        COMMIT;
        UPDATE load_unq_asset_cleaned_4_amc_info
        SET
            life_remaining = pkg_load_4_asset_amc_info.get_amc_life_remaining(estimated_useful_life, age);

        COMMIT;
        UPDATE load_unq_asset_cleaned_4_amc_info
        SET
            percent_life_consumed_number = pkg_load_4_asset_amc_info.get_amc_percent_life_consumed_number(estimated_useful_life, life_remaining);

        COMMIT;
        
         UPDATE load_unq_asset_cleaned_4_amc_info
        SET
            percent_life_consumed = percent_life_consumed_number*100;

        COMMIT;
        
        UPDATE load_unq_asset_cleaned_4_amc_info
        SET
            condition_adjusted_useful_life = pkg_load_4_asset_amc_info.get_amc_condition_adjusted_useful_life(condition_score, percent_life_consumed_number
            , estimated_useful_life, age);

        COMMIT;
        UPDATE load_unq_asset_cleaned_4_amc_info
        SET
            condition_adjusted_life_remaining = pkg_load_4_asset_amc_info.get_amc_condition_adjusted_life_remaining(condition_adjusted_useful_life
            , age);

        COMMIT;
        UPDATE load_unq_asset_cleaned_4_amc_info
        SET
            condition_adjusted_percent_life_consumed_number = pkg_load_4_asset_amc_info.get_amc_condition_adjusted_percent_life_consumed_number(estimated_useful_life
            , condition_adjusted_life_remaining);

        COMMIT;
        
         UPDATE load_unq_asset_cleaned_4_amc_info
        SET
            condition_adjusted_percent_life_consumed = condition_adjusted_percent_life_consumed_number*100;

        COMMIT;
        
        UPDATE load_unq_asset_cleaned_4_amc_info
        SET
            predicted_replacement_year = pkg_load_4_asset_amc_info.get_amc_predicted_replacement_year(condition_adjusted_life_remaining
            );

        COMMIT;
        UPDATE load_unq_asset_cleaned_4_amc_info
        SET
            predicted_cip_year = pkg_load_4_asset_amc_info.get_amc_predicted_cip_year(condition_adjusted_life_remaining);

        COMMIT;
    END;

    PROCEDURE start_data_refresh IS
    BEGIN
        proc_load_unq_asset_cleaned_4_amc_info;
    END;

END pkg_load_4_asset_amc_info;

/
