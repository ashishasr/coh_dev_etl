--------------------------------------------------------
--  DDL for Package Body PKG_EXECUTE_P9_LOAD_RESULTS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "COH_DEV_T"."PKG_EXECUTE_P9_LOAD_RESULTS" AS

    PROCEDURE load_t_out_all_asset_class_segmentation IS
    BEGIN
        execute immediate 'truncate table t_out_all_asset_class_segmentation';

        COMMIT;
        INSERT INTO t_out_all_asset_class_segmentation (
            data_unit,
            wwo_class_id,
            wwo_class_description,
            total_raw_asset_count,
            total_eam_asset_count,
            class_type
        )
            WITH x AS (
                SELECT
                    wwo_class_id,
                    wwo_class_description,
                    common_class_flag,
                    nvl(raw_data_unique_asset_count, 0) raw_asset_count,
                    nvl(eam_data_unique_asset_count, 0) eam_asset_count,
                    'UNIQUE'                            type
                FROM
                    coh_dev_t.wwo_segmnt_unq_asset_class_master
                UNION ALL
                SELECT
                    wwo_class_id,
                    wwo_class_description,
                    common_class_flag,
                    nvl(raw_tab1_data_common_asset_count + raw_tab2_data_common_asset_count, 0) raw_asset_count,
                    nvl(eam_data_common_asset_count, 0)                                         eam_asset_count,
                    'COMMON'                                                                    type
                FROM
                    coh_dev_t.wwo_segmnt_common_asset_class_master
            )
            SELECT
                y.data_unit,
                x.wwo_class_id,
                x.wwo_class_description,
                SUM(x.raw_asset_count) total_raw_asset_count,
                SUM(x.eam_asset_count) total_eam_asset_count,
                CASE
                    WHEN y.common_class_flag = 'Y' THEN
                        'KNOWN'
                    ELSE
                        'NET NEW'
                END                    class_type
            FROM
                     x
                INNER JOIN (
                    SELECT DISTINCT
                        wwo_class_id,
                        data_unit,
                        common_class_flag
                    FROM
                        coh_dev_t.wwo_segmnt_common_asset_class_master
                ) y ON x.wwo_class_id = y.wwo_class_id
            GROUP BY
                x.wwo_class_id,
                x.wwo_class_description,
                y.data_unit,
                y.common_class_flag
            ORDER BY
                1,
                3;

        COMMIT;
        MERGE INTO t_out_all_asset_class_segmentation t
        USING wwo_segmnt_unq_asset_class_master s ON ( t.wwo_class_id = s.wwo_class_id )
        WHEN MATCHED THEN UPDATE
        SET t.unq_raw_asset_count = s.raw_data_unique_asset_count,
            t.unq_eam_asset_count = s.eam_data_unique_asset_count;

        COMMIT;
        MERGE INTO t_out_all_asset_class_segmentation t
        USING wwo_segmnt_common_asset_class_master s ON ( t.wwo_class_id = s.wwo_class_id )
        WHEN MATCHED THEN UPDATE
        SET t.common_raw_asset_count = s.raw_tab1_data_common_asset_count + s.raw_tab2_data_common_asset_count,
            t.common_eam_asset_count = s.eam_data_common_asset_count;

        COMMIT;
    END;

    PROCEDURE load_validate_unq_asset_condition_q IS
    BEGIN
        execute immediate 'truncate table validate_unq_asset_condition_q';

        COMMIT;
-------------------------------------------------------------------------    
        INSERT INTO validate_unq_asset_condition_q (
            eam_class_id,
            asset_count,
            CONDiTION_Q,
            ref_condition_q,
            src_condition_q
        )
 SELECT DISTINCT
                src.eam_class_id,
                count(asset_id) asset_count,
                'CONDITION_Q1',
                ref.condition_q1 ref_condition_q1,
                src.condition_q1 src_condition_q1
            FROM
                     wwo_unq_asset_cleaned_no_calc src
                INNER JOIN t_in_wwo_condition_set_q_v ref ON src.eam_class_id = ref.class_id
                group by src.eam_class_id, ref.condition_q1,src.condition_q1
            ORDER BY 
                1;
                
        COMMIT;
    
    --------------------------------------------------------------------------------------------------------
    
      INSERT INTO validate_unq_asset_condition_q (
            eam_class_id,
            asset_count,
            CONDiTION_Q,
            ref_condition_q,
            src_condition_q
        )
            SELECT DISTINCT
                src.eam_class_id,
                 count(asset_id) asset_count,
                'CONDITION_Q2',
                ref.condition_q2 ref_condition_q2,
                src.condition_q2 src_condition_q2
            FROM
                     wwo_unq_asset_cleaned_no_calc src
                INNER JOIN t_in_wwo_condition_set_q_v ref ON src.eam_class_id = ref.class_id
                group by src.eam_class_id, ref.condition_q2,src.condition_q2
            ORDER BY
                1;

        COMMIT;
-------------------------------------------------------------------------------------------------------    

    
      INSERT INTO validate_unq_asset_condition_q (
            eam_class_id,
            asset_count,
            CONDiTION_Q,
            ref_condition_q,
            src_condition_q
        )
            SELECT DISTINCT
                src.eam_class_id,
                 count(asset_id) asset_count,
                'CONDITION_Q3',
                ref.condition_q3 ref_condition_q3,
                src.condition_q3 src_condition_q3
            FROM
                     wwo_unq_asset_cleaned_no_calc src
                INNER JOIN t_in_wwo_condition_set_q_v ref ON src.eam_class_id = ref.class_id
                group by src.eam_class_id, ref.condition_q3,src.condition_q3
            ORDER BY
                1;

        COMMIT;
-------------------------------------------------------------------------------------------------------      

    
      INSERT INTO validate_unq_asset_condition_q (
            eam_class_id,
            asset_count,
            CONDiTION_Q,
            ref_condition_q,
            src_condition_q
        )
            SELECT DISTINCT
                src.eam_class_id,
                 count(asset_id) asset_count,
                'CONDITION_Q4',
                ref.condition_q4 ref_condition_q4,
                src.condition_q4 src_condition_q4
            FROM
                     wwo_unq_asset_cleaned_no_calc src
                INNER JOIN t_in_wwo_condition_set_q_v ref ON src.eam_class_id = ref.class_id
                group by src.eam_class_id, ref.condition_q4,src.condition_q4
            ORDER BY
                1;

        COMMIT;
-------------------------------------------------------------------------------------------------------      

    
      INSERT INTO validate_unq_asset_condition_q (
            eam_class_id,
            asset_count,
            CONDiTION_Q,
            ref_condition_q,
            src_condition_q
        )
            SELECT DISTINCT
                src.eam_class_id,
                 count(asset_id) asset_count,
                'CONDITION_Q5',
                ref.condition_q5 ref_condition_q5,
                src.condition_q5 src_condition_q5
            FROM
                     wwo_unq_asset_cleaned_no_calc src
                INNER JOIN t_in_wwo_condition_set_q_v ref ON src.eam_class_id = ref.class_id
                group by src.eam_class_id, ref.condition_q5,src.condition_q5
            ORDER BY
                1;

        COMMIT;
-------------------------------------------------------------------------------------------------------      

    
      INSERT INTO validate_unq_asset_condition_q (
            eam_class_id,
            asset_count,
            CONDiTION_Q,
            ref_condition_q,
            src_condition_q
        )
            SELECT DISTINCT
                src.eam_class_id,
                 count(asset_id) asset_count,
                'CONDITION_Q6',
                ref.condition_q6 ref_condition_q6,
                src.condition_q6 src_condition_q6
            FROM
                     wwo_unq_asset_cleaned_no_calc src
                INNER JOIN t_in_wwo_condition_set_q_v ref ON src.eam_class_id = ref.class_id
                group by src.eam_class_id, ref.condition_q6,src.condition_q6
            ORDER BY
                1;

        COMMIT;
-------------------------------------------------------------------------------------------------------      

    
      INSERT INTO validate_unq_asset_condition_q (
            eam_class_id,
            asset_count,
            CONDiTION_Q,
            ref_condition_q,
            src_condition_q
        )
            SELECT DISTINCT
                src.eam_class_id,
                 count(asset_id) asset_count,
                'CONDITION_Q7',
                ref.condition_q7 ref_condition_q7,
                src.condition_q7 src_condition_q7
            FROM
                     wwo_unq_asset_cleaned_no_calc src
                INNER JOIN t_in_wwo_condition_set_q_v ref ON src.eam_class_id = ref.class_id
                group by src.eam_class_id, ref.condition_q7,src.condition_q7
            ORDER BY
                1;

        COMMIT;
-------------------------------------------------------------------------------------------------------      

    
      INSERT INTO validate_unq_asset_condition_q (
            eam_class_id,
            asset_count,
            CONDiTION_Q,
            ref_condition_q,
            src_condition_q
        )
            SELECT DISTINCT
                src.eam_class_id,
                 count(asset_id) asset_count,
                'CONDITION_Q8',
                ref.condition_q8 ref_condition_q8,
                src.condition_q8 src_condition_q8
            FROM
                     wwo_unq_asset_cleaned_no_calc src
                INNER JOIN t_in_wwo_condition_set_q_v ref ON src.eam_class_id = ref.class_id
                group by src.eam_class_id, ref.condition_q8,src.condition_q8
            ORDER BY
                1;

        COMMIT;
-------------------------------------------------------------------------------------------------------      

    
      INSERT INTO validate_unq_asset_condition_q (
            eam_class_id,
            asset_count,
            CONDiTION_Q,
            ref_condition_q,
            src_condition_q
        )
            SELECT DISTINCT
                src.eam_class_id,
                 count(asset_id) asset_count,
                'CONDITION_Q9',
                ref.condition_q9 ref_condition_q9,
                src.condition_q9 src_condition_q9
            FROM
                     wwo_unq_asset_cleaned_no_calc src
                INNER JOIN t_in_wwo_condition_set_q_v ref ON src.eam_class_id = ref.class_id
                group by src.eam_class_id, ref.condition_q9,src.condition_q9
            ORDER BY
                1;

        COMMIT;
-------------------------------------------------------------------------------------------------------      

    
      INSERT INTO validate_unq_asset_condition_q (
            eam_class_id,
            asset_count,
            CONDiTION_Q,
            ref_condition_q,
            src_condition_q
        )
            SELECT DISTINCT
                src.eam_class_id,
                 count(asset_id) asset_count,
                'CONDITION_Q10',
                ref.condition_q10 ref_condition_q10,
                src.condition_q10 src_condition_q10
            FROM
                     wwo_unq_asset_cleaned_no_calc src
                INNER JOIN t_in_wwo_condition_set_q_v ref ON src.eam_class_id = ref.class_id
                group by src.eam_class_id, ref.condition_q10,src.condition_q10
            ORDER BY
                1;

        COMMIT;
-------------------------------------------------------------------------------------------------------      
        
    update validate_unq_asset_condition_q 
    set Q_MATCH = 'Y' where SRC_CONDITION_Q = 'N/A';
    
    update validate_unq_asset_condition_q 
    set Q_MATCH = 'Y' where SRC_CONDITION_Q = REF_CONDItION_Q;
    
    update validate_unq_asset_condition_q 
    set Q_MATCH = 'Y' where SRC_CONDITION_Q || '?' = REF_CONDItION_Q;
    
    commit;
    ----------------------------------------------------------------------------------------------------
    
    
    END;

    PROCEDURE start_data_refresh IS
    BEGIN
        load_t_out_all_asset_class_segmentation;
        load_validate_unq_asset_condition_q;
    END;

END pkg_execute_p9_load_results;

/
