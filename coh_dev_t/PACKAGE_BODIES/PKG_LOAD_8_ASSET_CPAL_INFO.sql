--------------------------------------------------------
--  DDL for Package Body PKG_LOAD_8_ASSET_CPAL_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "COH_DEV_T"."PKG_LOAD_8_ASSET_CPAL_INFO" AS
-------------------------------------------------------------------------------
    FUNCTION get_cpal_1_action_timeframe_br1 (
        in_br1 VARCHAR
    ) RETURN VARCHAR IS
        out_cpal_1_action_timeframe_br1 NUMBER;
    BEGIN
        SELECT
            CASE
                WHEN in_br1 = 'URGENT'     THEN
                    0
                WHEN in_br1 = 'PRIORITY'   THEN
                    3
                WHEN in_br1 = 'SHORT-TERM' THEN
                    6
                WHEN in_br1 = 'MID-TERM'   THEN
                    11
                WHEN in_br1 = 'LONG-TERM'  THEN
                    21
                ELSE
                    NULL
            END
        INTO out_cpal_1_action_timeframe_br1
        FROM
            dual;

        RETURN out_cpal_1_action_timeframe_br1;
    END;

-------------------------------------------------------------------------------
    FUNCTION get_cpal_1_action_timeframe_br2 (
        in_br2 VARCHAR
    ) RETURN VARCHAR IS
        out_cpal_1_action_timeframe_br2 NUMBER;
    BEGIN
        SELECT
            CASE
                WHEN in_br2 = 'URGENT'     THEN
                    0
                WHEN in_br2 = 'PRIORITY'   THEN
                    3
                WHEN in_br2 = 'SHORT-TERM' THEN
                    6
                WHEN in_br2 = 'MID-TERM'   THEN
                    11
                WHEN in_br2 = 'LONG-TERM'  THEN
                    20
                ELSE
                    NULL
            END
        INTO out_cpal_1_action_timeframe_br2
        FROM
            dual;

        RETURN out_cpal_1_action_timeframe_br2;
    END;

------------------------------------------------------------------------------
    FUNCTION get_cpal_1_action_timeframe_br3 (
        in_br3 VARCHAR
    ) RETURN VARCHAR IS
        out_cpal_1_action_timeframe_br3 NUMBER;
    BEGIN
        SELECT
            CASE
                WHEN in_br3 = 'URGENT'     THEN
                    0
                WHEN in_br3 = 'PRIORITY'   THEN
                    3
                WHEN in_br3 = 'SHORT-TERM' THEN
                    6
                WHEN in_br3 = 'MID-TERM'   THEN
                    11
                WHEN in_br3 = 'LONG-TERM'  THEN
                    20
                ELSE
                    NULL
            END
        INTO out_cpal_1_action_timeframe_br3
        FROM
            dual;

        RETURN out_cpal_1_action_timeframe_br3;
    END;

------------------------------------------------------------------------------

    FUNCTION get_cpal_1_action_cost (
        in_class_id    VARCHAR,
        in_category_id VARCHAR
    ) RETURN NUMBER IS
        out_cpal_1_action_cost NUMBER;
    BEGIN
        SELECT
            cost_override
        INTO out_cpal_1_action_cost
        FROM
            wwo_cost_override_master
        WHERE
                class_id = in_class_id
            AND category_id = in_category_id;

        RETURN out_cpal_1_action_cost;
    END;
        
--------------------------------------------------------------------------------

    FUNCTION get_cpal_2_action (
        in_no_of_rehab NUMBER
    ) RETURN VARCHAR IS
        out_cpal_2_action VARCHAR(100);
    BEGIN
        SELECT
            CASE
                WHEN in_no_of_rehab > 1 THEN
                    'Rehab'
                ELSE
                    'Replace'
            END
        INTO out_cpal_2_action
        FROM
            dual;

        RETURN out_cpal_2_action;
    END;

--------------------------------------------------------------------------------

    FUNCTION get_cpal_2_action_timeframe_br1 (
        in_no_of_rehabs               NUMBER,
        in_first_action_timeframe_br1 NUMBER,
        in_rehab_eul                  NUMBER,
        in_replacement_eul            NUMBER
    ) RETURN NUMBER IS
        out_cpal_2_action_timeframe_br1 VARCHAR(100);
    BEGIN
        SELECT
            ceil(
                CASE
                    WHEN in_no_of_rehabs > 2 THEN
                        in_first_action_timeframe_br1 + in_rehab_eul
                    ELSE
                        in_replacement_eul + in_first_action_timeframe_br1
                END
            )
        INTO out_cpal_2_action_timeframe_br1
        FROM
            dual;

        RETURN out_cpal_2_action_timeframe_br1;
    END;

--------------------------------------------------------------------------------
    FUNCTION get_cpal_2_action_timeframe_br2 (
        in_no_of_rehabs               NUMBER,
        in_first_action_timeframe_br2 NUMBER,
        in_rehab_eul                  NUMBER,
        in_replacement_eul            NUMBER
    ) RETURN NUMBER IS
        out_cpal_2_action_timeframe_br2 NUMBER;
    BEGIN
        SELECT
            ceil(
                CASE
                    WHEN in_no_of_rehabs > 3 THEN
                        in_first_action_timeframe_br2 + in_rehab_eul
                    ELSE
                        in_first_action_timeframe_br2 + in_replacement_eul
                END
            )
        INTO out_cpal_2_action_timeframe_br2
        FROM
            dual;

        RETURN out_cpal_2_action_timeframe_br2;
    END;

--------------------------------------------------------------------------------
    FUNCTION get_cpal_2_action_timeframe_br3 (
        in_no_of_rehabs               NUMBER,
        in_first_action_timeframe_br3 NUMBER,
        in_rehab_eul                  NUMBER,
        in_replacement_eul            NUMBER
    ) RETURN NUMBER IS
        out_cpal_2_action_timeframe_br3 NUMBER;
    BEGIN
        SELECT
            ceil(
                CASE
                    WHEN in_no_of_rehabs > 2 THEN
                        in_first_action_timeframe_br3 + in_rehab_eul
                    ELSE
                        in_replacement_eul + in_first_action_timeframe_br3
                END
            )
        INTO out_cpal_2_action_timeframe_br3
        FROM
            dual;

        RETURN out_cpal_2_action_timeframe_br3;
    END;

--------------------------------------------------------------------------------
    FUNCTION get_cpal_2_action_cost (
        in_class_id          VARCHAR,
        in_category_id       VARCHAR,
        in_rehab_replacement VARCHAR
    ) RETURN VARCHAR IS
        out_cpal_2_action_cost VARCHAR(100);
    BEGIN
        SELECT
            total_cost
        INTO out_cpal_2_action_cost
        FROM
            wwo_cost_override_master lk
        WHERE
                lk.class_id = in_class_id
            AND lk.category_id = in_category_id
            AND lk.rehab_replacement = in_rehab_replacement;

        RETURN out_cpal_2_action_cost;
    END;
--------------------------------------------------------------------------------
    FUNCTION get_cpal_3_action (
        in_no_of_rehabs VARCHAR
    ) RETURN VARCHAR IS
        out_cpal_3_action VARCHAR(100);
    BEGIN
        SELECT
            CASE
                WHEN in_no_of_rehabs = 0
                     OR in_no_of_rehabs = 2 THEN
                    'Replace'
                ELSE
                    'Rehab'
            END
        INTO out_cpal_3_action
        FROM
            dual;

        RETURN out_cpal_3_action;
    END;

--------------------------------------------------------------------------------
    FUNCTION get_cpal_3_action_timeframe_br1 (
        in_no_of_rehabs                NUMBER,
        in_second_action_timeframe_br1 NUMBER,
        in_rehab_eul                   NUMBER,
        in_replacement_eul             NUMBER
    ) RETURN NUMBER IS
        out_cpal_3_action_timeframe_br1 NUMBER;
    BEGIN
        SELECT
            ceil(
                CASE
                    WHEN in_no_of_rehabs > 2 THEN
                        in_second_action_timeframe_br1 + in_rehab_eul
                    ELSE
                        in_replacement_eul + in_second_action_timeframe_br1
                END
            )
        INTO out_cpal_3_action_timeframe_br1
        FROM
            dual;

        RETURN out_cpal_3_action_timeframe_br1;
    END;

--------------------------------------------------------------------------------
    FUNCTION get_cpal_3_action_timeframe_br2 (
        in_no_of_rehabs                NUMBER,
        in_second_action_timeframe_br2 NUMBER,
        in_rehab_eul                   NUMBER,
        in_replacement_eul             NUMBER
    ) RETURN NUMBER IS
        out_cpal_3_action_timeframe_br2 VARCHAR(100);
    BEGIN
        SELECT
            ceil(
                CASE
                    WHEN in_no_of_rehabs > 3 THEN
                        in_second_action_timeframe_br2 + in_rehab_eul
                    ELSE
                        in_second_action_timeframe_br2 + in_replacement_eul
                END
            )
        INTO out_cpal_3_action_timeframe_br2
        FROM
            dual;

        RETURN out_cpal_3_action_timeframe_br2;
    END;

--------------------------------------------------------------------------------
    FUNCTION get_cpal_3_action_timeframe_br3 (
        in_no_of_rehabs                NUMBER,
        in_second_action_timeframe_br3 NUMBER,
        in_rehab_eul                   NUMBER,
        in_replacement_eul             NUMBER
    ) RETURN VARCHAR IS
        out_cpal_3_action_timeframe_br3 NUMBER;
    BEGIN
        SELECT
            ceil(
                CASE
                    WHEN in_no_of_rehabs > 2 THEN
                        in_second_action_timeframe_br3 + in_rehab_eul
                    ELSE
                        in_replacement_eul + in_second_action_timeframe_br3
                END
            )
        INTO out_cpal_3_action_timeframe_br3
        FROM
            dual;

        RETURN out_cpal_3_action_timeframe_br3;
    END;

--------------------------------------------------------------------------------
    FUNCTION get_cpal_3_action_cost (
        in_class_id    VARCHAR,
        in_category_id VARCHAR,
        in_3rd_action  VARCHAR
    ) RETURN NUMBER IS
        out_cpal_3_action_cost NUMBER;
    BEGIN
        SELECT
            total_cost
        INTO out_cpal_3_action_cost
        FROM
            wwo_cost_override_master lk
        WHERE
                lk.class_id = in_class_id
            AND lk.category_id = in_category_id
            AND lk.rehab_replacement = in_3rd_action;

        RETURN out_cpal_3_action_cost;
    END;
--------------------------------------------------------------------------------
    FUNCTION get_cpal_4_action (
        in_no_of_rehabs NUMBER
    ) RETURN VARCHAR IS
        out_cpal_4_action VARCHAR2(10);
    BEGIN
        SELECT
            CASE
                WHEN in_no_of_rehabs IN ( 0, 1, 3 ) THEN
                    'Replace'
                ELSE
                    'Rehab'
            END
        INTO out_cpal_4_action
        FROM
            dual;

        RETURN out_cpal_4_action;
    END;
--------------------------------------------------------------------------------
    FUNCTION get_cpal_4_action_timeframe_br1 (
        in_no_of_rehabs                NUMBER,
        in_second_action_timeframe_br1 NUMBER,
        in_rehab_eul                   NUMBER,
        in_third_action_timeframe_br1  NUMBER,
        in_replacement_eul             NUMBER
    ) RETURN NUMBER IS
        out_cpal_4_action_timeframe_br1 NUMBER;
    BEGIN
        SELECT
            ceil(
                CASE
                    WHEN in_no_of_rehabs > 3 THEN
                        in_second_action_timeframe_br1 + in_rehab_eul
                    ELSE
                        in_third_action_timeframe_br1 + in_replacement_eul
                END
            )
        INTO out_cpal_4_action_timeframe_br1
        FROM
            dual;

        RETURN out_cpal_4_action_timeframe_br1;
    END;
--------------------------------------------------------------------------------
    FUNCTION get_cpal_4_action_timeframe_br2 (
        in_no_of_rehabs                NUMBER,
        in_second_action_timeframe_br2 NUMBER,
        in_rehab_eul                   NUMBER,
        in_third_action_timeframe_br2  NUMBER,
        in_replacement_eul             NUMBER
    ) RETURN NUMBER IS
        out_cpal_4_action_timeframe_br2 NUMBER;
    BEGIN
        SELECT
            ceil(
                CASE
                    WHEN in_no_of_rehabs > 3 THEN
                        in_second_action_timeframe_br2 + in_rehab_eul
                    ELSE
                        in_third_action_timeframe_br2 + in_replacement_eul
                END
            )
        INTO out_cpal_4_action_timeframe_br2
        FROM
            dual;

        RETURN out_cpal_4_action_timeframe_br2;
    END;

--------------------------------------------------------------------------------

    FUNCTION get_cpal_4_action_timeframe_br3 (
        in_no_of_rehabs                NUMBER,
        in_second_action_timeframe_br3 NUMBER,
        in_rehab_eul                   NUMBER,
        in_third_action_timeframe_br3  NUMBER,
        in_replacement_eul             NUMBER
    ) RETURN NUMBER IS
        out_cpal_4_action_timeframe_br3 NUMBER;
    BEGIN
        SELECT
            ceil(
                CASE
                    WHEN in_no_of_rehabs > 3 THEN
                        in_second_action_timeframe_br3 + in_rehab_eul
                    ELSE
                        in_third_action_timeframe_br3 + in_replacement_eul
                END
            )
        INTO out_cpal_4_action_timeframe_br3
        FROM
            dual;

        RETURN out_cpal_4_action_timeframe_br3;
    END;

--------------------------------------------------------------------------------
    FUNCTION get_cpal_4_action_cost (
        in_class_id      VARCHAR,
        in_category_id   VARCHAR,
        in_fourth_action VARCHAR
    ) RETURN NUMBER IS
        out_cpal_4_action_cost NUMBER;
    BEGIN
        SELECT
            total_cost
        INTO out_cpal_4_action_cost
        FROM
            wwo_cost_override_master lk
        WHERE
                lk.class_id = in_class_id
            AND lk.category_id = in_category_id
            AND lk.rehab_replacement = in_fourth_action;

        RETURN out_cpal_4_action_cost;
    END;
--------------------------------------------------------------------------------
    FUNCTION get_cpal_timeframe (
        in_br3 VARCHAR
    ) RETURN VARCHAR IS
        out_timeframe VARCHAR(100);
    BEGIN
        SELECT
            CASE
                WHEN in_br3 = 'URGENT'     THEN
                    '0-2 Years'
                WHEN in_br3 = 'PRIORITY'   THEN
                    '3-5 Years'
                WHEN in_br3 = 'SHORT-TERM' THEN
                    '6-10 Years'
                WHEN in_br3 = 'MID-TERM'   THEN
                    '11-20 Years'
                WHEN in_br3 = 'LONG-TERM'  THEN
                    '20+ Years'
                ELSE
                    ''
            END
        INTO out_timeframe
        FROM
            dual;

        RETURN out_timeframe;
    END;

--------------------------------------------------------------------------------
    PROCEDURE proc_load_unq_asset_cleaned_8_cpal_info IS
    BEGIN
        execute immediate 'truncate table  load_unq_asset_cleaned_8_cpal_info';

        COMMIT;
        
        INSERT INTO load_unq_asset_cleaned_8_cpal_info (
            asset_id,
            class_id,
            category_id,
            br1,
            br2,
            br3,
            rehab_eul,
            no_of_rehab,
            replacement_eul,
            first_action,
            second_action_cost
        )
            WITH u AS (
                SELECT
                    a.asset_id,
                    a.class_id,
                    a.category_id,
                    b.br1,
                    b.br2,
                    b.br3,
                    c.rehab_eul,
                    c.max_no_of_rehabs               no_of_rehab,
                    e.condition_adjusted_useful_life replacement_eul,
                    c.initial_reinvestment_action    first_action,
                    d.total_cost                     second_action_cost
                FROM
                         load_unq_asset_cleaned_1_asset_info a
                    LEFT JOIN load_unq_asset_cleaned_7_brr_info b ON a.asset_id = b.asset_id
                    LEFT JOIN wwo_asset_types_master            c ON a.class_id = c.class_id 
                                                           AND a.category_id = c.category_id 
                    LEFT JOIN wwo_cost_override_master          d ON a.class_id = d.class_id
                                                             AND a.category_id = d.category_id 
                    LEFT JOIN load_unq_asset_cleaned_4_amc_info e ON e.asset_id = a.asset_id 
            )
            SELECT
                *
            FROM
                u;
                
        
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            first_action_timeframe_br_1 = pkg_load_8_asset_cpal_info.get_cpal_1_action_timeframe_br1(br1);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            first_action_timeframe_br_2 = pkg_load_8_asset_cpal_info.get_cpal_1_action_timeframe_br2(br2);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            first_action_timeframe_br_3 = pkg_load_8_asset_cpal_info.get_cpal_1_action_timeframe_br3(br3);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            first_action_cost = pkg_load_8_asset_cpal_info.get_cpal_1_action_cost(class_id, category_id);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            second_action = pkg_load_8_asset_cpal_info.get_cpal_2_action(no_of_rehab);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            second_action_timeframe_br_1 = pkg_load_8_asset_cpal_info.get_cpal_2_action_timeframe_br1(no_of_rehab, first_action_timeframe_br_1
            , rehab_eul, replacement_eul);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            second_action_timeframe_br_2 = pkg_load_8_asset_cpal_info.get_cpal_2_action_timeframe_br2(no_of_rehab, first_action_timeframe_br_2
            , rehab_eul, replacement_eul);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            second_action_timeframe_br_3 = pkg_load_8_asset_cpal_info.get_cpal_2_action_timeframe_br3(no_of_rehab, first_action_timeframe_br_3
            , rehab_eul, replacement_eul);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            third_action = pkg_load_8_asset_cpal_info.get_cpal_3_action(no_of_rehab);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            third_action_timeframe_br_1 = pkg_load_8_asset_cpal_info.get_cpal_3_action_timeframe_br1(no_of_rehab, second_action_timeframe_br_1
            , rehab_eul, replacement_eul);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            third_action_timeframe_br_2 = pkg_load_8_asset_cpal_info.get_cpal_3_action_timeframe_br2(no_of_rehab, second_action_timeframe_br_2
            , rehab_eul, replacement_eul);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            third_action_timeframe_br_3 = pkg_load_8_asset_cpal_info.get_cpal_3_action_timeframe_br3(no_of_rehab, second_action_timeframe_br_3
            , rehab_eul, replacement_eul);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            third_action_cost = pkg_load_8_asset_cpal_info.get_cpal_3_action_cost(class_id, category_id, third_action);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            fourth_action = pkg_load_8_asset_cpal_info.get_cpal_4_action(no_of_rehab);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            fourth_action_timeframe_br_1 = pkg_load_8_asset_cpal_info.get_cpal_4_action_timeframe_br1(no_of_rehab, second_action_timeframe_br_1
            , rehab_eul, third_action_timeframe_br_1, replacement_eul);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            fourth_action_timeframe_br_2 = pkg_load_8_asset_cpal_info.get_cpal_4_action_timeframe_br2(no_of_rehab, second_action_timeframe_br_2
            , rehab_eul, third_action_timeframe_br_2, replacement_eul);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            fourth_action_timeframe_br_3 = pkg_load_8_asset_cpal_info.get_cpal_4_action_timeframe_br3(no_of_rehab, second_action_timeframe_br_3
            , rehab_eul, third_action_timeframe_br_3, replacement_eul);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            fourth_action_cost = pkg_load_8_asset_cpal_info.get_cpal_4_action_cost(class_id, category_id, fourth_action);

        COMMIT;
        UPDATE load_unq_asset_cleaned_8_cpal_info
        SET
            timeframe = pkg_load_8_asset_cpal_info.get_cpal_timeframe(br3);

        COMMIT;
    END;
--------------------------------------------------------------------------------

    PROCEDURE start_data_refresh IS
    BEGIN
        proc_load_unq_asset_cleaned_8_cpal_info;
    END;

END pkg_load_8_asset_cpal_info;

/
