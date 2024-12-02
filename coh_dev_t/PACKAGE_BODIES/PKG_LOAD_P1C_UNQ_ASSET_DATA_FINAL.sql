--------------------------------------------------------
--  DDL for Package Body PKG_LOAD_P1C_UNQ_ASSET_DATA_FINAL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "COH_DEV_T"."PKG_LOAD_P1C_UNQ_ASSET_DATA_FINAL" AS

    PROCEDURE proc_load_segmnt_unq_asset_class_master_final IS
    BEGIN

/* update WWO_RAW_DATA_UNIQUE_ASSET_COUNT for the asset counts based on Raw Class Received*/
        MERGE INTO wwo_segmnt_unq_asset_class_master a
        USING (
            SELECT
                raw_class_id,
                COUNT(*) asset_count
            FROM
                wwo_unq_asset_status
            WHERE
                upper(eam_asset_status) <> 'WITHDRAWN'
            GROUP BY
                raw_class_id
        ) b ON ( a.wwo_class_id = b.raw_class_id )
        WHEN MATCHED THEN UPDATE
        SET a.raw_data_unique_asset_count = b.asset_count;

        COMMIT;

/* update - WWO_RAW_DATA_UNIQUE_ASSET_COUNT based on EAM Class*/
        MERGE INTO wwo_segmnt_unq_asset_class_master a
        USING (
            SELECT
                eam_class_id,
                COUNT(*) asset_count
            FROM
                wwo_unq_asset_status
            WHERE
                upper(eam_asset_status) <> 'WITHDRAWN'
            GROUP BY
                eam_class_id
        ) b ON ( a.wwo_class_id = b.eam_class_id )
        WHEN MATCHED THEN UPDATE
        SET a.eam_data_unique_asset_count = b.asset_count;

        COMMIT;
        
        /*Update where the Class count is 0*/
        
        UPDATE wwo_segmnt_unq_asset_class_master
        SET
            raw_data_unique_asset_count = 0
        WHERE
            raw_data_unique_asset_count IS NULL;
            
        /*Update where the Class count is 0*/
        UPDATE wwo_segmnt_unq_asset_class_master
        SET
            eam_data_unique_asset_count = 0
        WHERE
            eam_data_unique_asset_count IS NULL;

        COMMIT;

/* Updating classes only available in raw data sheet for assets and not there in EAM for the same assets*/
        INSERT INTO wwo_segmnt_unq_asset_class_master ( DATA_UNIT,
            wwo_class_id,
            wwo_class_description,
            common_new_comments
        )
            WITH a AS (
                SELECT DISTINCT
                    raw_class_id
                FROM
                    wwo_unq_asset_status
                MINUS
                SELECT DISTINCT
                    wwo_class_id
                FROM
                    wwo_segmnt_unq_asset_class_master
                ORDER BY
                    1
            )
            SELECT 11,
                raw_class_id,
                b.class_description,
                'This class is only avaialble in raw data sheet'
            FROM
                     a
                INNER JOIN wwo_class_description_master b ON a.raw_class_id = b.class_id;

        COMMIT;
    END;
    
--------------------------------------------------------------------------------------------------

    PROCEDURE proc_load_wwo_unq_asset_status_upd_asset_flg IS
    BEGIN

/*1. ASSET NOT IN EAM (DU 11) - Raw Data class ID is available.*/
        MERGE INTO wwo_unq_asset_status x
        USING (
            SELECT
                ua.asset_id
            FROM
                wwo_unq_asset_status ua
            WHERE
                    asset_in_eam_flag = 'N'
                AND ua.raw_class_id IS NOT NULL
                AND ua.checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'P',
            x.checked_flag = 'Y',
            x.status_comment = '1. ASSET NOT IN EAM (DU 11) - Raw Data class ID is available.';

        COMMIT;

/*2. ASSET NOT IN EAM (DU 11) - Raw Data class ID also not available.*/
        MERGE INTO wwo_unq_asset_status x
        USING (
            SELECT
                ua.asset_id
            FROM
                wwo_unq_asset_status ua
            WHERE
                    asset_in_eam_flag = 'N'
                AND ua.raw_class_id IS NULL
                AND ua.checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'P',
            x.checked_flag = 'Y',
            x.status_comment = '2. ASSET NOT IN EAM (DU 11) - Raw Data class ID also not available.';

        COMMIT;

/* 3. CLASS NOT IN EAM (DU 11) - CLASS ID available in raw data only */
        MERGE INTO wwo_unq_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_unq_asset_status
            WHERE
                    asset_in_eam_flag = 'Y'
                AND raw_class_id IS NOT NULL
                AND eam_class_id IS NULL
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'P',
            x.checked_flag = 'Y',
            x.status_comment = '3. CLASS NOT IN EAM (DU 11) - CLASS ID available in raw data only';

        COMMIT;

/* 4. CLASS NOT IN EAM (DU 11) - CLASS ID also not available in raw data*/
        MERGE INTO wwo_unq_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_unq_asset_status
            WHERE
                    asset_in_eam_flag = 'Y'
                AND raw_class_id IS NULL
                AND eam_class_id IS NULL
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'P',
            x.checked_flag = 'Y',
            x.status_comment = '4. CLASS NOT IN EAM (DU 11) - CLASS ID also not available in raw data';

        COMMIT;

/* 5. ASSET & CLASS both in EAM (DU 1 to 10) - Asset class NULL in raw data but available in EAM */
        MERGE INTO wwo_unq_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_unq_asset_status
            WHERE
                    asset_in_eam_flag = 'Y'
                AND raw_class_id IS NULL
                AND eam_class_id IS NOT NULL
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'C',
            x.checked_flag = 'Y',
            x.status_comment = '5. ASSET & CLASS both in EAM (DU 1 to 10) - Asset class NULL in raw data but available in EAM';

        COMMIT;

/* 6. ASSET & CLASS both in EAM (DU 1 to 10) - Asset having same class in (raw data and EAM) */
        MERGE INTO wwo_unq_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_unq_asset_status
            WHERE
                    asset_in_eam_flag = 'Y'
                AND raw_class_id = eam_class_id
                AND raw_class_id IS NOT NULL
                AND eam_class_id IS NOT NULL
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'C',
            x.checked_flag = 'Y',
            x.status_comment = '6. ASSET & CLASS both in EAM (DU 1 to 10) - Asset having same class in (raw data and EAM) ';

        COMMIT;

/* 7. ASSET & CLASS both in EAM (DU 1 to 10) - Asset having different class in raw data and EAM and both are non empty */
        MERGE INTO wwo_unq_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_unq_asset_status
            WHERE
                    asset_in_eam_flag = 'Y'
                AND raw_class_id <> eam_class_id
                AND raw_class_id IS NOT NULL
                AND eam_class_id IS NOT NULL
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'C',
            x.checked_flag = 'Y',
            x.status_comment = '7. ASSET & CLASS both in EAM (DU 1 to 10) - Asset having different class in raw data and EAM and both are non empty '
            ;

        COMMIT;

/* 8. Asset with Status withdrawn in EAM */
        MERGE INTO wwo_unq_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_unq_asset_status
            WHERE
                asset_id IN (
                    SELECT
                        asset_id
                    FROM
                        t_in_wwo_eam_system_extract_v
                    WHERE
                            upper(status) = 'WITHDRAWN'
                        AND asset_in_eam_flag = 'Y'
                )
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'W',
            x.checked_flag = 'Y',
            x.status_comment = '8. Asset with Status withdrawn in EAM';

        COMMIT;
    END;
---------------------------------------------------------------------------------------
    PROCEDURE proc_load_wwo_unq_asset_cleaned_no_calc IS
    BEGIN
    
    /* Loading only the assets which can be cleaned as per the status - 'C' */
        execute immediate 'truncate table wwo_unq_asset_cleaned_no_calc';

        COMMIT;
        INSERT INTO wwo_unq_asset_cleaned_no_calc (
            asset_id,
            eam_class_id,
            eam_class_description,
            eam_class_id_known_flag,
            eam_commission_date,
            raw_class_id,
            raw_class_description,
            raw_class_id_known_flag,
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
            src,
            category
        )
            SELECT
                u.asset_id,
                u.eam_class_id,
                u.eam_class_description,
                u.eam_class_id_known_flag,
                u.eam_commission_date,
                u.raw_class_id,
                u.raw_class_description,
                u.raw_class_id_known_flag,
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
                r.source src,
                --nvl(m.category, am.category_id)
                m.category
            FROM
                     wwo_unq_asset_2b_cleaned r
                INNER JOIN wwo_unq_asset_status u ON r.asset_id = u.asset_id
                                                     AND u.asset_status = 'C'
                left join   WWO_EAM_SYSTEM_EXTRACT_MASTER m on m.asset_id = r.asset_id;
                 --left join  WWO_ASSET_TYPES_MASTER am on am.class_id = r.class_id and DU11_FLAG = 'N';

        COMMIT;
        
                /* Update the data unit*/
MERGE INTO wwo_unq_asset_cleaned_no_calc a
USING (
    SELECT
        data_unit,
        wwo_class_id
    FROM
        wwo_segmnt_unq_asset_class_master
) b ON ( a.eam_class_id = b.wwo_class_id )
WHEN MATCHED THEN UPDATE
SET a.du = b.data_unit;

COMMIT;
        --------------------- for DU 11 assets cleaned ------------------------
        
        INSERT INTO wwo_unq_asset_cleaned_no_calc (
    asset_id,
    eam_class_id,
    eam_class_description,
    eam_class_id_known_flag,
    eam_commission_date,
    raw_class_id,
    raw_class_description,
    raw_class_id_known_flag,
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
    src,
    du,
    category
)
    SELECT
        asset_id,
        eam_class_id,
        eam_class_description,
        eam_class_id_known_flag,
        eam_commission_date,
        raw_class_id,
        raw_class_description,
        raw_class_id_known_flag,
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
        src,
        '11',
        category
    FROM
        wwo_unq_asset_parked
        
    WHERE
        cleaned_flag = 'Y';
        
        commit;
        

        
    END;
    
---------------------------------------------------------------------------------------
    PROCEDURE proc_load_wwo_unq_asset_cleaned_no_calc_condition_q IS
    BEGIN
        execute immediate 'truncate table wwo_unq_asset_cleaned_no_calc_condition_q';

        INSERT INTO wwo_unq_asset_cleaned_no_calc_condition_q (
            asset_id,
            class_id,
            class_description,
            raw_condition_q_no,
            raw_condition_q,
            raw_condition_a_no,
            raw_condition_a
        )
            WITH subq_1 AS (
                SELECT
                    asset_id,
                    eam_class_id                            class_id,
                    eam_class_description                   class_description,
                    substr(condition_q_no,
                           instr(condition_q_no, '_Q') + 2) qa_no,
                    condition_q_no,
                    condition_q
                FROM
                    wwo_unq_asset_cleaned_no_calc UNPIVOT ( condition_q
                        FOR condition_q_no
                    IN ( condition_q1,
                         condition_q2,
                         condition_q3,
                         condition_q4,
                         condition_q5,
                         condition_q6,
                         condition_q7,
                         condition_q8,
                         condition_q9,
                         condition_q10 ) )
                ORDER BY
                    eam_class_id,
                    condition_q_no
            ), subq_2 AS (
                SELECT
                    asset_id,
                    eam_class_id                            class_id,
                    eam_class_description                   class_description,
                    substr(condition_a_no,
                           instr(condition_a_no, '_A') + 2) qa_no,
                    condition_a_no,
                    condition_a
                FROM
                    wwo_unq_asset_cleaned_no_calc UNPIVOT ( condition_a
                        FOR condition_a_no
                    IN ( condition_a1,
                         condition_a2,
                         condition_a3,
                         condition_a4,
                         condition_a5,
                         condition_a6,
                         condition_a7,
                         condition_a8,
                         condition_a9,
                         condition_a10 ) )
                ORDER BY
                    eam_class_id,
                    condition_a_no
            )
            SELECT
                subq_1.asset_id,
                subq_1.class_id,
                subq_1.class_description,
                condition_q_no,
                condition_q,
                condition_a_no,
                condition_a
            FROM
                     subq_1
                INNER JOIN subq_2 ON subq_1.asset_id = subq_2.asset_id
                                     AND subq_1.class_id = subq_2.class_id
                                     AND subq_1.qa_no = subq_2.qa_no;

        COMMIT;
    END;
    
-----------------------------------------------------------------------------------

    PROCEDURE proc_load_wwo_unq_asset_condition_set_q_master_key IS
    BEGIN
        execute immediate 'truncate table wwo_unq_asset_condition_set_q_master_key';

        INSERT INTO wwo_unq_asset_condition_set_q_master_key (
            raw_condition_q_id,
            class_id,
            class_description,
            raw_condition_q_no,
            raw_condition_q
        )
            WITH ds1 AS (
                SELECT DISTINCT
                    class_id,
                    class_description,
                    raw_condition_q_no,
                    raw_condition_q
                FROM
                    wwo_unq_asset_cleaned_no_calc_condition_q
            )
            SELECT
                ROWNUM,
                class_id,
                class_description,
                raw_condition_q_no,
                raw_condition_q
            FROM
                ds1
            ORDER BY
                class_description,
                raw_condition_q_no;

        COMMIT;
        MERGE INTO wwo_unq_asset_cleaned_no_calc_condition_q t
        USING wwo_unq_asset_condition_set_q_master_key s ON ( t.class_id = s.class_id
                                                              AND t.class_description = s.class_description
                                                              AND t.raw_condition_q_no = s.raw_condition_q_no
                                                              AND t.raw_condition_q = s.raw_condition_q )
        WHEN MATCHED THEN UPDATE
        SET t.raw_condition_q_id = s.raw_condition_q_id;

        COMMIT;
    END;
----------------------------------------------------------------------------------------------------        

    PROCEDURE proc_load_wwo_unq_asset_parked IS
    BEGIN
        execute immediate 'truncate table wwo_unq_asset_parked';

        COMMIT;
        INSERT INTO wwo_unq_asset_parked (
            asset_id,
            eam_class_id,
            eam_class_description,
            eam_class_id_known_flag,
            eam_commission_date,
            raw_class_id,
            raw_class_description,
            raw_class_id_known_flag,
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
            src,
            status_comment
        )
            SELECT
                u.asset_id,
                u.eam_class_id,
                u.eam_class_description,
                u.eam_class_id_known_flag,
                u.eam_commission_date,
                u.raw_class_id,
                u.raw_class_description,
                u.raw_class_id_known_flag,
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
                r.source src,
                status_comment
            FROM
                     wwo_unq_asset_2b_cleaned r
                INNER JOIN wwo_unq_asset_status u ON r.asset_id = u.asset_id
                                                     AND u.asset_status = 'P';

        COMMIT;
        
        update wwo_unq_asset_parked
        set data_unit = '11.1', class_type = 'NOT COUNTED';
        commit;
        
    ------------------ update performed for PARKED unique 72 assets to move it to cleaned ------
    
MERGE INTO wwo_unq_asset_parked a
USING t_in_du_11_assets_detail_v b ON ( a.asset_id = b.asset_id )
WHEN MATCHED THEN UPDATE
SET a.eam_class_id = b.class_id,
    a.eam_class_description = b.wwo_class_description,
    a.cleaned_flag = 'Y',
    a.category = replace(b.category,'*',NULL);
    
commit;
    ------------------ update performed for PARKED unique 72 assets to move it to cleaned ------
        
        
        
    END;
-----------------------------------------------------------------------------------

    PROCEDURE start_data_refresh IS
    BEGIN
        proc_load_segmnt_unq_asset_class_master_final;
        proc_load_wwo_unq_asset_status_upd_asset_flg;
        proc_load_wwo_unq_asset_parked;
        proc_load_wwo_unq_asset_cleaned_no_calc;
        proc_load_wwo_unq_asset_cleaned_no_calc_condition_q;
        proc_load_wwo_unq_asset_condition_set_q_master_key;
    END;

END pkg_load_p1c_unq_asset_data_final;

/
