--------------------------------------------------------
--  DDL for Package Body PKG_EXECUTE_P4_UNQ_ASSET_COND_Q_MAP
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "COH_DEV_T"."PKG_EXECUTE_P4_UNQ_ASSET_COND_Q_MAP" AS

    PROCEDURE proc_load_unq_asset_condition_q_map IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table unq_asset_condition_q_map';
        COMMIT;
        INSERT INTO unq_asset_condition_q_map (
            data_unit,
            class_id,
            class_description,
            raw_condition_q_id,
            raw_condition_q_no,
            raw_condition_q,
            rcd_checked,
            match_comments,
            final_ref_condition_q_id,
            final_ref_condition_q_no,
            final_ref_condition_q
        )
            SELECT
                seg.data_unit,
                raw1.class_id,
                raw1.class_description,
                raw_condition_q_id,
                raw_condition_q_no,
                raw_condition_q,
                'N',
                '5. Not Processed',
                c.ref_condition_q_id,
                c.ref_condition_q_no,
                c.ref_condition_q
            FROM
                wwo_unq_asset_condition_set_q_master_key raw1
                LEFT JOIN wwo_segmnt_unq_asset_class_master        seg ON seg.wwo_class_id = raw1.class_id
                                                                   AND seg.wwo_class_description = raw1.class_description
                LEFT JOIN wwo_condition_set_q_master_key           c ON c.class_id = raw1.class_id
                                                              AND c.ref_condition_q_no = raw_condition_q_no;

        COMMIT;
        
---------------------------------------------------------------------------------------------

        MERGE INTO unq_asset_condition_q_map target
        USING (
            SELECT
                class_id,
                class_description,
                ref_condition_q_id,
                ref_condition_q_no,
                ref_condition_q
            FROM
                wwo_condition_set_q_master_key
        ) source ON ( source.class_id = target.class_id
                      --AND source.class_description = target.class_description
                      AND source.ref_condition_q_no = target.raw_condition_q_no
                      AND source.ref_condition_q = target.raw_condition_q )
        WHEN MATCHED THEN UPDATE
        SET target.ref_condition_q_id = source.ref_condition_q_id,
            target.ref_condition_q_no = source.ref_condition_q_no,
            target.ref_condition_q = source.ref_condition_q,
            target.final_ref_condition_q_id = source.ref_condition_q_id,
            target.final_ref_condition_q_no = source.ref_condition_q_no,
            target.final_ref_condition_q = source.ref_condition_q,
            target.rcd_checked = 'Y',
            target.match_comments = '1. Raw Assets Condition Q are same as Reference Condition Q'
        WHERE
            target.rcd_checked = 'N';

        COMMIT;
        
    ----------------------------------------------------------------    

        MERGE INTO unq_asset_condition_q_map target
        USING (
            SELECT
                data_unit,
                class_id,
                class_description,
                raw_condition_q_no,
                raw_condition_q,
                ref_condition_q_no,
                ref_condition_q
            FROM
                t_in_wwo_condition_q_solution_v
            WHERE
                proceed = 'Y'
        ) source ON ( source.class_description = target.class_description
                      AND source.raw_condition_q_no = target.raw_condition_q_no
                      AND source.raw_condition_q = target.raw_condition_q )
        WHEN MATCHED THEN UPDATE
        SET --target.final_ref_condition_q_id = source.ref_condition_q_id,
         target.final_ref_condition_q_no = source.ref_condition_q_no,
            target.final_ref_condition_q = source.ref_condition_q,
            target.rcd_checked = 'Y',
            target.match_comments = '6. Solution Provided by Hexagon'
        WHERE
            target.rcd_checked = 'N';

        COMMIT;

        
---------------------------------------------------------------------------------------------

        MERGE INTO unq_asset_condition_q_map target
        USING (
            SELECT
                class_id,
                class_description,
                ref_condition_q_id,
                ref_condition_q_no,
                ref_condition_q
            FROM
                wwo_condition_set_q_master_key
        ) source ON ( source.class_id = target.class_id
                      --AND source.class_description = target.class_description
                      AND source.ref_condition_q_no = target.raw_condition_q_no )
        WHEN MATCHED THEN UPDATE
        SET target.final_ref_condition_q_id = source.ref_condition_q_id,
            target.final_ref_condition_q_no = source.ref_condition_q_no,
            target.final_ref_condition_q = source.ref_condition_q,
            target.rcd_checked = 'Y',
            target.match_comments = '2. Raw Asset Condition Q is N/A'
        WHERE
                target.rcd_checked = 'N'
            AND target.raw_condition_q = 'N/A';

        COMMIT;

----------------------------------------------------------------------------------------------
        MERGE INTO unq_asset_condition_q_map target
        USING (
            SELECT
                class_id,
                class_description,
                ref_condition_q_id,
                ref_condition_q_no,
                ref_condition_q
            FROM
                wwo_condition_set_q_master_key
        ) source ON ( source.class_id = target.class_id
                      --AND source.class_description = target.class_description
                      AND source.ref_condition_q_no = target.raw_condition_q_no
                      AND source.ref_condition_q = target.raw_condition_q || '?' )
        WHEN MATCHED THEN UPDATE
        SET target.final_ref_condition_q_id = source.ref_condition_q_id,
            target.final_ref_condition_q_no = source.ref_condition_q_no,
            target.final_ref_condition_q = source.ref_condition_q,
            target.rcd_checked = 'Y',
            target.match_comments = '3. Only ''?'' is Missing in Raw Asset Condition Q'
        WHERE
            target.rcd_checked = 'N';

        COMMIT;
    END;

----------------------------------------------------------------------------------------------

    PROCEDURE update_source_table IS
  -- Declare variables  
        v_src_class_id              VARCHAR(2000);
        v_src_raw_condition_q_id    VARCHAR(2000);
        v_src_raw_condition_q_no    VARCHAR(2000);
        v_src_raw_condition_q       VARCHAR(2000);
        v_lookup_class_id           VARCHAR(2000);
        v_lookup_ref_condition_q_id VARCHAR(2000);
        v_lookup_ref_condition_q_no VARCHAR(2000);
        v_lookup_ref_condition_q    VARCHAR(2000);

  -- Cursor to traverse source_table
        CURSOR cur_source IS
        SELECT
            class_id,
            raw_condition_q_id,
            raw_condition_q_no,
            raw_condition_q
        FROM
            unq_asset_condition_q_map
        WHERE
            rcd_checked = 'N';

    BEGIN
  -- Open cursor to traverse source_table
        FOR rec IN cur_source LOOP
            v_src_class_id := rec.class_id;
            v_src_raw_condition_q_id := rec.raw_condition_q_id;
            v_src_raw_condition_q_no := rec.raw_condition_q_no;
            v_src_raw_condition_q := rec.raw_condition_q;
            BEGIN
                SELECT
                    class_id,
                    ref_condition_q_id,
                    ref_condition_q_no,
                    ref_condition_q
                INTO
                    v_lookup_class_id,
                    v_lookup_ref_condition_q_id,
                    v_lookup_ref_condition_q_no,
                    v_lookup_ref_condition_q
                FROM
                    wwo_condition_set_q_master_key
                WHERE
                        ref_condition_q = v_src_raw_condition_q
                    AND class_id = v_src_class_id;

            EXCEPTION
                WHEN no_data_found THEN
        -- Handle the case where no matching row is found in lookup_table
                    NULL;
            END;

    -- Update the source_table with the fetched lookup_value
            UPDATE unq_asset_condition_q_map
            SET
                final_ref_condition_q_id = v_lookup_ref_condition_q_id,
                final_ref_condition_q_no = v_lookup_ref_condition_q_no,
                final_ref_condition_q = v_lookup_ref_condition_q,
                rcd_checked = 'Y',
                match_comments = '4. Condition Q Sequence is different with Raw Assets and Reference Condition Q'
            WHERE
                    class_id = v_lookup_class_id
                AND raw_condition_q = v_lookup_ref_condition_q
                AND rcd_checked = 'N';

        END LOOP;

  -- Commit changes
        COMMIT;

  -- Optionally, print a message
        dbms_output.put_line('Update completed.');
    EXCEPTION
        WHEN OTHERS THEN
    -- Handle exceptions and rollback in case of errors
            ROLLBACK;
            dbms_output.put_line('Error occurred: ' || sqlerrm);
    END update_source_table;
-----------------------------------------------------------------------------

    PROCEDURE upd_wwo_unq_asset_cleaned_no_calc_condition_q IS
    BEGIN
        MERGE INTO wwo_unq_asset_cleaned_no_calc_condition_q t
        USING unq_asset_condition_q_map s ON ( t.raw_condition_q_id = s.raw_condition_q_id )
        WHEN MATCHED THEN UPDATE
        SET t.final_ref_condition_q_id = s.final_ref_condition_q_id,
            t.final_ref_condition_q_no = s.final_ref_condition_q_no,
            t.final_ref_condition_q = s.final_ref_condition_q,
            t.match_comments = s.match_comments;

        COMMIT;
        UPDATE wwo_unq_asset_cleaned_no_calc_condition_q
        SET
            final_condition_a = raw_condition_a
        WHERE
            match_comments = '1. Raw Assets Condition Q are same as Reference Condition Q';

        COMMIT;
        UPDATE wwo_unq_asset_cleaned_no_calc_condition_q
        SET
            final_condition_a = '0'
        WHERE
            match_comments = '2. Raw Asset Condition Q is N/A';

        COMMIT;
        UPDATE wwo_unq_asset_cleaned_no_calc_condition_q
        SET
            final_condition_a = raw_condition_a
        WHERE
            match_comments = '3. Only ''?'' is Missing in Raw Asset Condition Q';

        COMMIT;
        UPDATE wwo_unq_asset_cleaned_no_calc_condition_q
        SET
            final_condition_a = raw_condition_a
        WHERE
            match_comments = '4. Condition Q Sequence is different with Raw Assets and Reference Condition Q';

        COMMIT;
        UPDATE wwo_unq_asset_cleaned_no_calc_condition_q
        SET
            final_condition_a = '0'
        WHERE
            match_comments = '5. Not Processed';

        COMMIT;
        
                UPDATE wwo_unq_asset_cleaned_no_calc_condition_q
        SET
            final_condition_a = raw_condition_a
        WHERE
            match_comments = '6. Solution Provided by Hexagon';

        COMMIT;
    END;

-----------------------------------------------------------------------------
    PROCEDURE proc_load_wwo_unq_asset_cleaned_no_calc_condition_q_t IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wwo_unq_asset_cleaned_no_calc_condition_q_t';
        INSERT INTO wwo_unq_asset_cleaned_no_calc_condition_q_t (
            asset_id,
            class_id,
            class_description,
            condition_q1,
            condition_a1,
            condition_q2,
            condition_a2,
            condition_q3,
            condition_a3,
            condition_q4,
            condition_a4,
            condition_q5,
            condition_a5,
            condition_q6,
            condition_a6,
            condition_q7,
            condition_a7,
            condition_q8,
            condition_a8,
            condition_q9,
            condition_a9,
            condition_q10,
            condition_a10
        )
            SELECT
                asset_id,
                class_id,
                class_description,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q1' THEN
                            final_ref_condition_q
                    END
                ) AS condition_q1,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q1' THEN
                            final_condition_a
                    END
                ) AS condition_a1,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q2' THEN
                            final_ref_condition_q
                    END
                ) AS condition_q2,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q2' THEN
                            final_condition_a
                    END
                ) AS condition_a2,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q3' THEN
                            final_ref_condition_q
                    END
                ) AS condition_q3,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q3' THEN
                            final_condition_a
                    END
                ) AS condition_a3,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q4' THEN
                            final_ref_condition_q
                    END
                ) AS condition_q4,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q4' THEN
                            final_condition_a
                    END
                ) AS condition_a4,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q5' THEN
                            final_ref_condition_q
                    END
                ) AS condition_q5,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q5' THEN
                            final_condition_a
                    END
                ) AS condition_a5,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q6' THEN
                            final_ref_condition_q
                    END
                ) AS condition_q6,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q6' THEN
                            final_condition_a
                    END
                ) AS condition_a6,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q7' THEN
                            final_ref_condition_q
                    END
                ) AS condition_q7,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q7' THEN
                            final_condition_a
                    END
                ) AS condition_a7,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q8' THEN
                            final_ref_condition_q
                    END
                ) AS condition_q8,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q8' THEN
                            final_condition_a
                    END
                ) AS condition_a8,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q9' THEN
                            final_ref_condition_q
                    END
                ) AS condition_q9,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q9' THEN
                            final_condition_a
                    END
                ) AS condition_a9,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q10' THEN
                            final_ref_condition_q
                    END
                ) AS condition_q10,
                MAX(
                    CASE
                        WHEN final_ref_condition_q_no = 'CONDITION_Q10' THEN
                            final_condition_a
                    END
                ) AS condition_a10
            FROM
                wwo_unq_asset_cleaned_no_calc_condition_q
            GROUP BY
                asset_id,
                class_id,
                class_description;

        COMMIT;
        
        -- case where we have same condirion Q for an asset and one condition q is not populated.

        MERGE INTO wwo_unq_asset_cleaned_no_calc_condition_q_t t
        USING wwo_condition_set_q_master s ON ( t.class_id = s.class_id )
        WHEN MATCHED THEN UPDATE
        SET t.condition_q1 = s.condition_q1
        WHERE
            t.condition_q1 IS NULL;

        COMMIT;
        MERGE INTO wwo_unq_asset_cleaned_no_calc_condition_q_t t
        USING wwo_condition_set_q_master s ON ( t.class_id = s.class_id )
        WHEN MATCHED THEN UPDATE
        SET t.condition_q2 = s.condition_q2
        WHERE
            t.condition_q2 IS NULL;

        COMMIT;
        MERGE INTO wwo_unq_asset_cleaned_no_calc_condition_q_t t
        USING wwo_condition_set_q_master s ON ( t.class_id = s.class_id )
        WHEN MATCHED THEN UPDATE
        SET t.condition_q3 = s.condition_q3
        WHERE
            t.condition_q3 IS NULL;

        COMMIT;
        MERGE INTO wwo_unq_asset_cleaned_no_calc_condition_q_t t
        USING wwo_condition_set_q_master s ON ( t.class_id = s.class_id )
        WHEN MATCHED THEN UPDATE
        SET t.condition_q4 = s.condition_q4
        WHERE
            t.condition_q4 IS NULL;

        COMMIT;
        MERGE INTO wwo_unq_asset_cleaned_no_calc_condition_q_t t
        USING wwo_condition_set_q_master s ON ( t.class_id = s.class_id )
        WHEN MATCHED THEN UPDATE
        SET t.condition_q5 = s.condition_q5
        WHERE
            t.condition_q5 IS NULL;

        COMMIT;
        MERGE INTO wwo_unq_asset_cleaned_no_calc_condition_q_t t
        USING wwo_condition_set_q_master s ON ( t.class_id = s.class_id )
        WHEN MATCHED THEN UPDATE
        SET t.condition_q6 = s.condition_q6
        WHERE
            t.condition_q6 IS NULL;

        COMMIT;
        MERGE INTO wwo_unq_asset_cleaned_no_calc_condition_q_t t
        USING wwo_condition_set_q_master s ON ( t.class_id = s.class_id )
        WHEN MATCHED THEN UPDATE
        SET t.condition_q7 = s.condition_q7
        WHERE
            t.condition_q7 IS NULL;

        COMMIT;
        MERGE INTO wwo_unq_asset_cleaned_no_calc_condition_q_t t
        USING wwo_condition_set_q_master s ON ( t.class_id = s.class_id )
        WHEN MATCHED THEN UPDATE
        SET t.condition_q8 = s.condition_q8
        WHERE
            t.condition_q8 IS NULL;

        COMMIT;
        MERGE INTO wwo_unq_asset_cleaned_no_calc_condition_q_t t
        USING wwo_condition_set_q_master s ON ( t.class_id = s.class_id )
        WHEN MATCHED THEN UPDATE
        SET t.condition_q9 = s.condition_q9
        WHERE
            t.condition_q9 IS NULL;

        COMMIT;
        MERGE INTO wwo_unq_asset_cleaned_no_calc_condition_q_t t
        USING wwo_condition_set_q_master s ON ( t.class_id = s.class_id )
        WHEN MATCHED THEN UPDATE
        SET t.condition_q10 = s.condition_q10
        WHERE
            t.condition_q10 IS NULL;

        COMMIT;
        UPDATE wwo_unq_asset_cleaned_no_calc_condition_q_t
        SET
            condition_a1 = 0
        WHERE
            condition_a1 IS NULL;

        UPDATE wwo_unq_asset_cleaned_no_calc_condition_q_t
        SET
            condition_a2 = 0
        WHERE
            condition_a2 IS NULL;

        UPDATE wwo_unq_asset_cleaned_no_calc_condition_q_t
        SET
            condition_a3 = 0
        WHERE
            condition_a3 IS NULL;

        UPDATE wwo_unq_asset_cleaned_no_calc_condition_q_t
        SET
            condition_a4 = 0
        WHERE
            condition_a4 IS NULL;

        UPDATE wwo_unq_asset_cleaned_no_calc_condition_q_t
        SET
            condition_a5 = 0
        WHERE
            condition_a5 IS NULL;

        UPDATE wwo_unq_asset_cleaned_no_calc_condition_q_t
        SET
            condition_a6 = 0
        WHERE
            condition_a6 IS NULL;

        UPDATE wwo_unq_asset_cleaned_no_calc_condition_q_t
        SET
            condition_a7 = 0
        WHERE
            condition_a7 IS NULL;

        UPDATE wwo_unq_asset_cleaned_no_calc_condition_q_t
        SET
            condition_a8 = 0
        WHERE
            condition_a8 IS NULL;

        UPDATE wwo_unq_asset_cleaned_no_calc_condition_q_t
        SET
            condition_a9 = 0
        WHERE
            condition_a9 IS NULL;

        UPDATE wwo_unq_asset_cleaned_no_calc_condition_q_t
        SET
            condition_a10 = 0
        WHERE
            condition_a10 IS NULL;

        COMMIT;
    END;

----------------------------------------------------------------------------
    PROCEDURE start_data_refresh IS
    BEGIN
        proc_load_unq_asset_condition_q_map;
        update_source_table;
        upd_wwo_unq_asset_cleaned_no_calc_condition_q;
        proc_load_wwo_unq_asset_cleaned_no_calc_condition_q_t;
    END;

END pkg_execute_p4_unq_asset_cond_q_map;

/
