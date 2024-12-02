--------------------------------------------------------
--  DDL for Procedure UPDATE_SOURCE_TABLE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "COH_DEV_T"."UPDATE_SOURCE_TABLE" IS
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
        unq_asset_condition_q_map where rcd_checked = 'N';

BEGIN
  -- Open cursor to traverse source_table
    FOR rec IN cur_source LOOP
    -- Fetch the id from source_table
    --v_id := rec.id;

        v_src_class_id := rec.class_id;
        v_src_raw_condition_q_id := rec.raw_condition_q_id;
        v_src_raw_condition_q_no := rec.raw_condition_q_no;
        v_src_raw_condition_q := rec.raw_condition_q;

    -- Lookup the corresponding value from lookup_table based on id
        BEGIN
            SELECT
                CLASS_ID,
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
            rcd_checked = 'C',
            match_comments = 'NOW'
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

/
