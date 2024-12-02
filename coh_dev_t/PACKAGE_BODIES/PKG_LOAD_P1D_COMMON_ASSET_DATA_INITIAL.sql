--------------------------------------------------------
--  DDL for Package Body PKG_LOAD_P1D_COMMON_ASSET_DATA_INITIAL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "COH_DEV_T"."PKG_LOAD_P1D_COMMON_ASSET_DATA_INITIAL" IS

    PROCEDURE proc_load_wwo_segmnt_common_asset_class_master IS
    BEGIN
        execute immediate 'truncate table wwo_segmnt_common_asset_class_master';

        COMMIT;
        INSERT INTO wwo_segmnt_common_asset_class_master (
            data_unit,
            dwo_class_id,
            dwo_class_description,
            wwo_class_id,
            wwo_class_description,
            common_class_flag,
            common_new_comments,
            segmentation_comments
        )
            SELECT DISTINCT
                data_unit,
                dwo_class_id,
                dwo_class_description,
                wwo_class_id,
                wwo_class_description,
                common_class_flag,
                common_new_comments,
                segmentation_comments
            FROM
                t_in_wwo_class_segmentation_v
            ORDER BY
                1;

        COMMIT;
    END;
------------------------------------------------------------------    
    PROCEDURE proc_load_wwo_common_asset_2b_cleaned IS
    BEGIN
        execute immediate 'truncate table wwo_common_asset_2b_cleaned';

        COMMIT;
        INSERT INTO wwo_common_asset_2b_cleaned (
            asset_id,
            class_id,
            class_description,
            status,
            commission_date,
            performance_capacity,
            performance_reliability,
            performance_om,
            performance_obsolescence,
            performance_redundancy,
            performance_erul,
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
            condition_a10,
            cof_replacement_cost,
            cof_om_impacts,
            cof_level_of_service,
            cof_health_and_safety,
            cof_permit_compliance,
            cof_response_time,
            cof_service_priority,
            source
        )
            WITH ca AS (
                (
                    SELECT DISTINCT
                        asset_id
                    FROM
                        t_in_wwo_raw_tab1_v
                    INTERSECT
                    SELECT DISTINCT
                        asset_id
                    FROM
                        t_in_wwo_raw_tab2_v
                )
            ), rd AS (
                SELECT
                    asset_id,
                    class_id,
                    class_description,
                    status,
                    commission_date,
                    performance_capacity,
                    performance_reliability,
                    performance_om,
                    performance_obsolescence,
                    performance_redundancy,
                    performance_erul,
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
                    condition_a10,
                    cof_replacement_cost,
                    cof_om_impacts,
                    cof_level_of_service,
                    cof_health_and_safety,
                    cof_permit_compliance,
                    cof_response_time,
                    cof_service_priority,
                    'tab1' tab
                FROM
                    t_in_wwo_raw_tab1_v
                WHERE
                    asset_id IS NOT NULL
                UNION ALL
                SELECT
                    asset_id,
                    class_id,
                    class_description,
                    status,
                    commission_date,
                    performance_capacity,
                    performance_reliability,
                    performance_om,
                    performance_obsolescence,
                    performance_redundancy,
                    performance_erul,
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
                    condition_a10,
                    cof_replacement_cost,
                    cof_om_impacts,
                    cof_level_of_service,
                    cof_health_and_safety,
                    cof_permit_compliance,
                    cof_response_time,
                    cof_service_priority,
                    'tab2' tab
                FROM
                    t_in_wwo_raw_tab2_v
                WHERE
                    asset_id IS NOT NULL
            )
            SELECT
                rd.asset_id,
                rd.class_id,
                rd.class_description,
                rd.status,
                rd.commission_date,
                nvl(rd.performance_capacity, 0),
                nvl(rd.performance_reliability, 0),
                nvl(rd.performance_om, 0),
                nvl(rd.performance_obsolescence, 0),
                nvl(rd.performance_redundancy, 0),
                nvl(rd.performance_erul, 0),
                nvl(rd.condition_q1, 'N/A'),
                nvl(rd.condition_a1, 0),
                nvl(rd.condition_q2, 'N/A'),
                nvl(rd.condition_a2, 0),
                nvl(rd.condition_q3, 'N/A'),
                nvl(rd.condition_a3, 0),
                nvl(rd.condition_q4, 'N/A'),
                nvl(rd.condition_a4, 0),
                nvl(rd.condition_q5, 'N/A'),
                nvl(rd.condition_a5, 0),
                nvl(rd.condition_q6, 'N/A'),
                nvl(rd.condition_a6, 0),
                nvl(rd.condition_q7, 'N/A'),
                nvl(rd.condition_a7, 0),
                nvl(rd.condition_q8, 'N/A'),
                nvl(rd.condition_a8, 0),
                nvl(rd.condition_q9, 'N/A'),
                nvl(rd.condition_a9, 0),
                nvl(rd.condition_q10, 'N/A'),
                nvl(rd.condition_a10, 0),
                nvl(rd.cof_replacement_cost, 0),
                nvl(rd.cof_om_impacts, 0),
                nvl(rd.cof_level_of_service, 0),
                nvl(rd.cof_health_and_safety, 0),
                nvl(rd.cof_permit_compliance, 0),
                nvl(rd.cof_response_time, 0),
                nvl(rd.cof_service_priority, 0),
                upper(rd.tab) excel_tab
            FROM
                     rd
                INNER JOIN ca ON rd.asset_id = ca.asset_id
            ORDER BY
                1;

        COMMIT;
    END;
-------------------------------------------------------------------------------
        PROCEDURE proc_load_wwo_common_asset_status IS
    BEGIN
        execute immediate 'truncate table wwo_common_asset_status';

        COMMIT;
        INSERT INTO wwo_common_asset_status ( asset_id )
            SELECT DISTINCT
                asset_id
            FROM
                wwo_common_asset_2b_cleaned;

        COMMIT;

/* Tab1 update for raw data*/
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                a.asset_id,
                a.class_id,
                b.class_description,
                c.common_class_flag
            FROM
                     t_in_wwo_raw_tab1_v a
                LEFT JOIN wwo_class_description_master         b ON a.class_id = b.class_id
                LEFT JOIN wwo_segmnt_common_asset_class_master c ON c.wwo_class_id = a.class_id
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.raw_tab1_class_id = y.class_id,
            x.raw_tab1_class_description = y.class_description,
            x.raw_tab1_class_id_known_flag = y.common_class_flag;

        COMMIT;


/* Tab2 update for raw data*/
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                a.asset_id,
                a.class_id,
                b.class_description,
                c.common_class_flag
            FROM
                     t_in_wwo_raw_tab2_v a
                LEFT JOIN wwo_class_description_master         b ON a.class_id = b.class_id
                LEFT JOIN wwo_segmnt_common_asset_class_master c ON c.wwo_class_id = a.class_id
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.raw_tab2_class_id = y.class_id,
            x.raw_tab2_class_description = y.class_description,
            x.raw_tab2_class_id_known_flag = y.common_class_flag;

        COMMIT;


/* Asset update for eam data for EAM CLass*/
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                a.asset_id,
                a.class_id,
                b.class_description,
                c.common_class_flag,
                a.commission_date,
                a.status
            FROM
                     wwo_eam_system_extract_master a
                LEFT JOIN wwo_class_description_master         b ON a.class_id = b.class_id
                LEFT JOIN wwo_segmnt_common_asset_class_master c ON c.wwo_class_id = a.class_id
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.eam_class_id = y.class_id,
            x.eam_class_description = y.class_description,
            x.eam_class_id_known_flag = y.common_class_flag,
            x.asset_in_eam_flag = 'Y',
            x.eam_commission_date = TO_DATE(y.commission_date, 'MM/DD/YYYY'),
            x.eam_asset_status = y.status;

        COMMIT;
    END;

------------------------------------------------------------------------------

    PROCEDURE start_data_refresh IS
    BEGIN
        proc_load_wwo_segmnt_common_asset_class_master;
        proc_load_wwo_common_asset_2b_cleaned;
        proc_load_wwo_common_asset_status;
    END;

END pkg_load_p1d_common_asset_data_initial;

/
