--------------------------------------------------------
--  DDL for Package Body PKG_LOAD_P1E_COMMON_ASSET_DATA_FINAL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "COH_DEV_T"."PKG_LOAD_P1E_COMMON_ASSET_DATA_FINAL" AS

    PROCEDURE proc_load_wwo_segmnt_common_asset_class_master_final IS
    BEGIN

/* update T_common_ASSET_CLASS_SEG_MST for WWO_RAW_DATA_TAB1_COMMON_ASSET_CNT*/
        MERGE INTO wwo_segmnt_common_asset_class_master a
        USING (
            SELECT
                raw_tab1_class_id,
                COUNT(*) asset_count
            FROM
                wwo_common_asset_status
            WHERE
                upper(eam_asset_status) <> 'WITHDRAWN'
            GROUP BY
                raw_tab1_class_id
        ) b ON ( a.wwo_class_id = b.raw_tab1_class_id )
        WHEN MATCHED THEN UPDATE
        SET a.raw_tab1_data_common_asset_count = nvl(b.asset_count, 0);

        COMMIT;

/* update T_common_ASSET_CLASS_SEG_MST for WWO_RAW_DATA_TAB2_COMMON_ASSET_CNT*/
        MERGE INTO wwo_segmnt_common_asset_class_master a
        USING (
            SELECT
                raw_tab2_class_id,
                COUNT(*) asset_count
            FROM
                wwo_common_asset_status
            WHERE
                upper(eam_asset_status) <> 'WITHDRAWN'
            GROUP BY
                raw_tab2_class_id
        ) b ON ( a.wwo_class_id = b.raw_tab2_class_id )
        WHEN MATCHED THEN UPDATE
        SET a.raw_tab2_data_common_asset_count = nvl(b.asset_count, 0);

        COMMIT;

/* update - WWO_SEGMNT_COMMON_ASSET_CLASS_MASTER */
        MERGE INTO wwo_segmnt_common_asset_class_master a
        USING (
            SELECT
                eam_class_id,
                COUNT(*) asset_count
            FROM
                wwo_common_asset_status
            WHERE
                upper(eam_asset_status) <> 'WITHDRAWN'
            GROUP BY
                eam_class_id
        ) b ON ( a.wwo_class_id = b.eam_class_id )
        WHEN MATCHED THEN UPDATE
        SET a.eam_data_common_asset_count = nvl(b.asset_count, 0);

        COMMIT;
        UPDATE wwo_segmnt_common_asset_class_master
        SET
            raw_tab1_data_common_asset_count = 0
        WHERE
            raw_tab1_data_common_asset_count IS NULL;

        UPDATE wwo_segmnt_common_asset_class_master
        SET
            raw_tab2_data_common_asset_count = 0
        WHERE
            raw_tab2_data_common_asset_count IS NULL;

        UPDATE wwo_segmnt_common_asset_class_master
        SET
            eam_data_common_asset_count = 0
        WHERE
            eam_data_common_asset_count IS NULL;

        COMMIT;

/* Updating classes only available in raw data sheet*/
        INSERT INTO wwo_segmnt_common_asset_class_master (
            wwo_class_id,
            wwo_class_description,
            common_new_comments
        )
            WITH a AS (
                (
                    SELECT DISTINCT
                        raw_tab1_class_id raw_class_id
                    FROM
                        wwo_common_asset_status
                    UNION
                    SELECT DISTINCT
                        raw_tab2_class_id raw_class_id
                    FROM
                        wwo_common_asset_status
                )
                MINUS
                SELECT DISTINCT
                    wwo_class_id
                FROM
                    wwo_segmnt_common_asset_class_master
            )
            SELECT
                raw_class_id,
                b.class_description,
                'This class is only avaialble in raw data sheet'
            FROM
                     a
                INNER JOIN wwo_class_description_master b ON a.raw_class_id = b.class_id;

        COMMIT;
    END;

--------------------------------------------------------------------------------------------------

    PROCEDURE proc_load_wwo_common_asset_status_upd_asset_status IS
    BEGIN

/* 1. ASSET NOT IN EAM (DU 11) - Tab1 Class ID and Tab2 Class ID are available.*/
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_common_asset_status
            WHERE
                    asset_in_eam_flag = 'N'
                AND raw_tab1_class_id IS NOT NULL
                AND raw_tab2_class_id IS NOT NULL
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'P',
            x.checked_flag = 'Y',
            x.status_comment = '01. ASSET NOT IN EAM (DU 11) - Tab1 Class ID and Tab2 Class ID are available.';

        COMMIT;

/* 2. ASSET NOT IN EAM (DU 11) - Tab1 Class ID and Tab2 Class ID both not available.*/
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_common_asset_status
            WHERE
                    asset_in_eam_flag = 'N'
                AND raw_tab1_class_id IS NULL
                AND raw_tab2_class_id IS NULL
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'P',
            x.checked_flag = 'Y',
            x.status_comment = '02. ASSET NOT IN EAM - Tab1 Class ID and Tab2 Class ID both not available.';

        COMMIT;

/* 3. ASSET NOT IN EAM (DU 11)- Tab1 Class ID is available but Tab2 Class ID is not available.*/
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_common_asset_status
            WHERE
                    asset_in_eam_flag = 'N'
                AND raw_tab1_class_id IS NOT NULL
                AND raw_tab2_class_id IS NULL
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'P',
            x.checked_flag = 'Y',
            x.status_comment = '03. ASSET NOT IN EAM (DU 11)- Tab1 Class ID is available but Tab2 Class ID is not available.';

        COMMIT;

/* 4. ASSET NOT IN EAM (DU 11)- Tab1 Class ID is not available butTab2 Class ID is available. */
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_common_asset_status
            WHERE
                    asset_in_eam_flag = 'N'
                AND raw_tab1_class_id IS NOT NULL
                AND raw_tab2_class_id IS NULL
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'P',
            x.checked_flag = 'Y',
            x.status_comment = '04. ASSET NOT IN EAM (DU 11)- Tab1 Class ID is not available butTab2 Class ID is available. ';

/* 5. CLASS NOT IN EAM but Asset is in in EAM (DU 11) - Class available in Tab1 and Tab2.*/
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_common_asset_status
            WHERE
                    asset_in_eam_flag = 'Y'
                AND raw_tab1_class_id IS NOT NULL
                AND raw_tab2_class_id IS NOT NULL
                AND eam_class_id IS NULL
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'P',
            x.checked_flag = 'Y',
            x.status_comment = '05. CLASS NOT IN EAM but Asset is in in EAM (DU 11) - Class available in Tab1 and Tab2.';

/* 6. CLASS NOT IN EAM but Asset is in in EAM (DU 11) - Class availabe in Tab1 only.*/
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_common_asset_status
            WHERE
                    asset_in_eam_flag = 'Y'
                AND raw_tab1_class_id IS NOT NULL
                AND raw_tab2_class_id IS NULL
                AND eam_class_id IS NULL
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'P',
            x.checked_flag = 'Y',
            x.status_comment = '06. CLASS NOT IN EAM but Asset is in in EAM (DU 11) - Class availabe in Tab1 only.';

/* 7. CLASS NOT IN EAM but Asset is in in EAM (DU 11) - Class availabe in Tab2 only.*/
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_common_asset_status
            WHERE
                    asset_in_eam_flag = 'Y'
                AND raw_tab1_class_id IS NULL
                AND raw_tab2_class_id IS NOT NULL
                AND eam_class_id IS NULL
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'P',
            x.checked_flag = 'Y',
            x.status_comment = '07. CLASS NOT IN EAM but Asset is in in EAM (DU 11) - Class availabe in Tab2 only.';

        COMMIT;    

/* 8. CLASS NOT IN EAM but Asset is in in EAM (DU 11) - Class not availabe in Tab1 and Tab2.*/
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_common_asset_status
            WHERE
                    asset_in_eam_flag = 'Y'
                AND raw_tab1_class_id IS NULL
                AND raw_tab2_class_id IS NULL
                AND eam_class_id IS NULL
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'P',
            x.checked_flag = 'Y',
            x.status_comment = '08. CLASS NOT IN EAM but Asset is in in EAM (DU 11) - Class not availabe in Tab1 and Tab2.';

        COMMIT;    

/* 9. ASSET & CLASS both in EAM (DU 1 to 10) - Class ID not avaialbe in (Tab1 and Tab2).*/
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_common_asset_status
            WHERE
                    asset_in_eam_flag = 'Y'
                AND raw_tab1_class_id IS NULL
                AND raw_tab2_class_id IS NULL
                AND eam_class_id IS NOT NULL
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'C',
            x.checked_flag = 'Y',
            x.status_comment = '09. ASSET & CLASS both in EAM (DU 1 to 10) - Class ID not avaialbe in (Tab1 and Tab2).';

        COMMIT;    

/* 10. ASSET & CLASS both in EAM (DU 1 to 10) - Asset having same Class ID in (Tab1 and Tab2) and same Class ID in EAM. */
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_common_asset_status
            WHERE
                    asset_in_eam_flag = 'Y'
                AND raw_tab1_class_id = raw_tab2_class_id
                AND eam_class_id = raw_tab2_class_id
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'C',
            x.checked_flag = 'Y',
            x.status_comment = '10. ASSET & CLASS both in EAM (DU 1 to 10) - Asset having same Class ID in (Tab1 and Tab2) and same Class ID in EAM."
';

        COMMIT;   

/* 11. ASSET & CLASS both in EAM (DU 1 to 10) - Asset having same Class ID in (Tab1 and Tab2) and different Class ID in EAM.*/
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_common_asset_status
            WHERE
                    asset_in_eam_flag = 'Y'
                AND raw_tab1_class_id = raw_tab2_class_id
                AND eam_class_id <> raw_tab2_class_id
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'C',
            x.checked_flag = 'Y',
            x.status_comment = '11. ASSET & CLASS both in EAM (DU 1 to 10) - Asset having same Class ID in (Tab1 and Tab2) and different Class ID in EAM.'
            ;

        COMMIT;    

/* 12. ASSET & CLASS both in EAM (DU 1 to 10) - Asset having same Class ID in (EAM and Tab1) and different Class ID in Tab2.*/
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_common_asset_status
            WHERE
                    asset_in_eam_flag = 'Y'
                AND raw_tab1_class_id = eam_class_id
                AND eam_class_id <> raw_tab2_class_id
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'C',
            x.checked_flag = 'Y',
            x.status_comment = '12. ASSET & CLASS both in EAM (DU 1 to 10) - Asset having same Class ID in (EAM and Tab1) and different Class ID in Tab2.'
            ;

        COMMIT;    

/* 13. ASSET & CLASS both in EAM (DU 1 to 10) - Asset having same Class ID in (EAM and Tab2) and different Class ID in Tab1. */
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_common_asset_status
            WHERE
                    asset_in_eam_flag = 'Y'
                AND raw_tab2_class_id = eam_class_id
                AND eam_class_id <> raw_tab1_class_id
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'C',
            x.checked_flag = 'Y',
            x.status_comment = '13. ASSET & CLASS both in EAM (DU 1 to 10) - Asset having same Class ID in (EAM and Tab2) and different Class ID in Tab1.'
            ;

        COMMIT;    

/* 14. ASSET & CLASS both in EAM (DU 1 to 10) - Asset having different Class ID in Tab1 and Tab2 and EAM.*/
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_common_asset_status
            WHERE
                    asset_in_eam_flag = 'Y'
                AND raw_tab1_class_id <> raw_tab2_class_id
                AND raw_tab1_class_id <> eam_class_id
                AND raw_tab2_class_id <> eam_class_id
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'C',
            x.checked_flag = 'Y',
            x.status_comment = '14. ASSET & CLASS both in EAM (DU 1 to 10) - Asset having different Class ID in Tab1 and Tab2 and EAM.'
            ;

        COMMIT;    

/* 15. ASSET & CLASS both in EAM (DU 1 to 10) - Tab1 class ID available, Tab2 class not available.*/
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_common_asset_status
            WHERE
                    asset_in_eam_flag = 'Y'
                AND raw_tab1_class_id IS NOT NULL
                AND raw_tab2_class_id IS NULL
                AND eam_class_id IS NOT NULL
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'C',
            x.checked_flag = 'Y',
            x.status_comment = '15. ASSET & CLASS both in EAM (DU 1 to 10) - Tab1 class ID available, Tab2 class not available.';

        COMMIT;   

/* 16. ASSET & CLASS both in EAM (DU 1 to 10) - Tab1 class ID not available, Tab2 class available.*/
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_common_asset_status
            WHERE
                    asset_in_eam_flag = 'Y'
                AND raw_tab1_class_id IS NULL
                AND raw_tab2_class_id IS NOT NULL
                AND eam_class_id IS NOT NULL
                AND checked_flag = 'N'
        ) y ON ( x.asset_id = y.asset_id )
        WHEN MATCHED THEN UPDATE
        SET x.asset_status = 'C',
            x.checked_flag = 'Y',
            x.status_comment = '16. ASSET & CLASS both in EAM (DU 1 to 10) - Tab1 class ID not available, Tab2 class available.';

        COMMIT;   

/* 17 - Asset with Status withdrawn in EAM */
        MERGE INTO wwo_common_asset_status x
        USING (
            SELECT
                asset_id
            FROM
                wwo_common_asset_status
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
            x.status_comment = '17 - Asset with Status withdrawn in EAM';

        COMMIT;
    END;
---------------------------------------------------------------------------------------
    PROCEDURE proc_load_wwo_common_asset_cleaned_no_calc IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wwo_common_asset_cleaned_no_calc';
        COMMIT;
        INSERT INTO wwo_common_asset_cleaned_no_calc (
            asset_id,
            eam_class_id,
            eam_class_description,
            eam_class_id_known_flag,
            eam_commission_date,
            raw_tab1_class_id,
            raw_tab1_class_description,
            raw_tab1_class_id_known_flag,
            raw_tab2_class_id,
            raw_tab2_class_description,
            raw_tab2_class_id_known_flag,
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
            all_zero_flag,
            reject_flag,
            category
        )
            SELECT
                u.asset_id,
                u.eam_class_id,
                u.eam_class_description,
                u.eam_class_id_known_flag,
                u.eam_commission_date,
                u.raw_tab1_class_id,
                u.raw_tab1_class_description,
                u.raw_tab1_class_id_known_flag,
                u.raw_tab2_class_id,
                u.raw_tab2_class_description,
                u.raw_tab2_class_id_known_flag,
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
                source src,
                'N',
                'N',
                --nvl(m.category, am.category_id)
                m.category
            FROM
                     wwo_common_asset_2b_cleaned r
                INNER JOIN wwo_common_asset_status u ON r.asset_id = u.asset_id
                                                        AND u.asset_status = 'C'
            left join   WWO_EAM_SYSTEM_EXTRACT_MASTER m on m.asset_id = r.asset_id;
            --left join  WWO_ASSET_TYPES_MASTER am on am.class_id = r.class_id and DU11_FLAG = 'N';
commit;                                                        
                                                                                                                        /* Update the data unit*/
MERGE INTO wwo_common_asset_cleaned_no_calc a
USING (
    SELECT
        data_unit,
        wwo_class_id
    FROM
        wwo_segmnt_common_asset_class_master
) b ON ( a.eam_class_id = b.wwo_class_id )
WHEN MATCHED THEN UPDATE
SET a.du = b.data_unit;

COMMIT;
-- DU 11 Cleaned Assets, insert               
  INSERT INTO wwo_common_asset_cleaned_no_calc (
            asset_id,
            eam_class_id,
            eam_class_description,
            eam_class_id_known_flag,
            eam_commission_date,
            raw_tab1_class_id,
            raw_tab1_class_description,
            raw_tab1_class_id_known_flag,
            raw_tab2_class_id,
            raw_tab2_class_description,
            raw_tab2_class_id_known_flag,
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
            reject_flag,
            du, category
        )
          SELECT
    asset_id,
    eam_class_id,
    eam_class_description,
    eam_class_id_known_flag,
    eam_commission_date,
    raw_tab1_class_id,
    raw_tab1_class_description,
    raw_tab1_class_id_known_flag,
    raw_tab2_class_id,
    raw_tab2_class_description,
    raw_tab2_class_id_known_flag,
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
    'N', '11', category
FROM
    wwo_common_asset_parked where cleaned_flag = 'Y' and src = 'TAB1';
commit;
--------- DU 11
                                                        


        ------------------------------------------------------------------------
        
        UPDATE wwo_common_asset_cleaned_no_calc
        SET
            all_zero_flag = 'Y'
        WHERE
                performance_capacity = 0
            AND performance_reliability = 0
            AND performance_om = 0
            AND performance_obsolescence = 0
            AND performance_redundancy = 0
            AND performance_erul = 0
            AND condition_a1 = 0
            AND condition_a2 = 0
            AND condition_a3 = 0
            AND condition_a4 = 0
            AND condition_a5 = 0
            AND condition_a6 = 0
            AND condition_a7 = 0
            AND condition_a8 = 0
            AND condition_a9 = 0
            AND condition_a10 = 0
            AND cof_replacement_cost = 0
            AND cof_om_impacts = 0
            AND cof_level_of_service = 0
            AND cof_health_and_safety = 0
            AND cof_permit_compliance = 0
            AND cof_response_time = 0
            AND cof_service_priority = 0;

        COMMIT;
        UPDATE wwo_common_asset_cleaned_no_calc
        SET
            all_zero_flag = 'N'
        WHERE
            performance_capacity <> 0
            OR performance_reliability <> 0
            OR performance_om <> 0
            OR performance_obsolescence <> 0
            OR performance_redundancy <> 0
            OR performance_erul <> 0
            OR condition_a1 <> 0
            OR condition_a2 <> 0
            OR condition_a3 <> 0
            OR condition_a4 <> 0
            OR condition_a5 <> 0
            OR condition_a6 <> 0
            OR condition_a7 <> 0
            OR condition_a8 <> 0
            OR condition_a9 <> 0
            OR condition_a10 <> 0
            OR cof_replacement_cost <> 0
            OR cof_om_impacts <> 0
            OR cof_level_of_service <> 0
            OR cof_health_and_safety <> 0
            OR cof_permit_compliance <> 0
            OR cof_response_time <> 0
            OR cof_service_priority <> 0;

        COMMIT;
        ------------------------------------------------------------------------------
        UPDATE wwo_common_asset_cleaned_no_calc a
        SET
            reject_flag = 'Y',
            reject_accept_comments = '1. Rejecting this asset record as it has all 0 values and other non - 0 values record exists'
        WHERE
            asset_id IN (
                SELECT
                    asset_id
                FROM
                    wwo_common_asset_cleaned_no_calc
                WHERE
                    all_zero_flag = 'Y'
                INTERSECT
                SELECT
                    asset_id
                FROM
                    wwo_common_asset_cleaned_no_calc
                WHERE
                    all_zero_flag = 'N'
            )
            AND all_zero_flag = 'Y';

        COMMIT;
        UPDATE wwo_common_asset_cleaned_no_calc a
        SET
            reject_flag = 'N',
            reject_accept_comments = '2. This record is accepted has it has non 0 values and other asset record is rejected'
        WHERE
            asset_id IN (
                SELECT
                    asset_id
                FROM
                    wwo_common_asset_cleaned_no_calc
                WHERE
                    all_zero_flag = 'Y'
                INTERSECT
                SELECT
                    asset_id
                FROM
                    wwo_common_asset_cleaned_no_calc
                WHERE
                    all_zero_flag = 'N'
            )
            AND all_zero_flag = 'N';

        COMMIT;
        ---------------------------------------------------------------------------------------
        UPDATE wwo_common_asset_cleaned_no_calc
SET
    same_condition_q_flag = 'Y', REJECT_ACCEPT_COMMENTS = '3. This record is neither accepted nor rejected as both asset records has same consition Q and answers are non 0'
WHERE
    asset_id IN (
        WITH a AS (
            SELECT
                asset_id, condition_q1, condition_q2, condition_q3, condition_q4,
                condition_q5, condition_q6, condition_q7, condition_q8, condition_q9,
                condition_q10
            FROM
                wwo_common_asset_cleaned_no_calc
            WHERE
                    src = 'TAB1'
                AND reject_flag = 'N'
            INTERSECT
            SELECT
                asset_id, condition_q1, condition_q2, condition_q3, condition_q4,
                condition_q5, condition_q6, condition_q7, condition_q8, condition_q9,
                condition_q10
            FROM
                wwo_common_asset_cleaned_no_calc
            WHERE
                    src = 'TAB2'
                AND reject_flag = 'N'
        )
        SELECT
            asset_id
        FROM
            a
    );
    
    commit;
  
-------------------------------------


MERGE INTO WWO_COMMON_ASSET_CLEANED_NO_CALC t
USING T_IN_WWO_COMMON_ASSET_ACCEPT_V s
ON (t.asset_id = s.asset_id and t.src = s.src)
WHEN MATCHED THEN
    UPDATE SET
        t.reject_flag = s.reject_flag;

        commit;
        
--- info provided by Hexagon

update WWO_COMMON_ASSET_CLEANED_NO_CALC set reject_flag = 'Y' where REJECT_ACCEPT_COMMENTS like '3%'
and src = 'TAB2';

update WWO_COMMON_ASSET_CLEANED_NO_CALC set reject_flag = 'Y' where eam_class_id 
in (select WWO_CLASS_ID from  T_IN_WWO_CLASS_SEGMENTATION_V  where data_unit not in (1,2,3,4,5,6,7,8)) ;

commit;

-- handling DU 9,10

update WWO_COMMON_ASSET_CLEANED_NO_CALC set reject_flag = 'Y', REJECT_ACCEPT_COMMENTS = '' where du in (9,10)
and src = 'TAB2' ;
commit;

update WWO_COMMON_ASSET_CLEANED_NO_CALC set reject_flag = 'N', REJECT_ACCEPT_COMMENTS = '' where du in (9,10)
and src = 'TAB1';
commit;
        
      END;
-----------------------------------------------------------------------------------


    PROCEDURE proc_load_wwo_common_asset_cleaned_no_calc_condition_q IS
    BEGIN
        execute immediate 'truncate table wwo_common_asset_cleaned_no_calc_condition_q';

        INSERT INTO wwo_common_asset_cleaned_no_calc_condition_q (
            asset_id,
            class_id,
            class_description,
            raw_condition_q_no,
            raw_condition_q,
            raw_condition_a_no,
            raw_condition_a,
            src
        )
            WITH subq_1 AS (
                SELECT
                    asset_id,
                    eam_class_id                            class_id,
                    eam_class_description                   class_description,
                    substr(condition_q_no,
                           instr(condition_q_no, '_Q') + 2) qa_no,
                    condition_q_no,
                    condition_q, 
                    src
                FROM
                    wwo_common_asset_cleaned_no_calc UNPIVOT ( condition_q
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
                         condition_q10 ) ) where
                         REJECT_FLAG = 'N' 
                         --and REJECT_ACCEPT_COMMENTS is null
                         --and REJECT_ACCEPT_COMMENTS <> '3. This record is neither accepted nor rejected as both asset records has same consition Q nd answers are non 0'               
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
                    condition_a,
                    src
                FROM
                    wwo_common_asset_cleaned_no_calc UNPIVOT ( condition_a
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
                         condition_a10 ) ) where
                         REJECT_FLAG = 'N' 
                         and src = 'TAB1' -- change for DU 11
                         
                         --and REJECT_ACCEPT_COMMENTS is null
                         --and REJECT_ACCEPT_COMMENTS <> '3. This record is neither accepted nor rejected as both asset records has same consition Q nd answers are non 0'
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
                condition_a,
                subq_1.src
            FROM
                     subq_1
                INNER JOIN subq_2 ON subq_1.asset_id = subq_2.asset_id
                                     AND subq_1.class_id = subq_2.class_id
                                     AND subq_1.qa_no = subq_2.qa_no
                                     AND subq_1.src = subq_2.src;

        COMMIT;
    END;
    
-----------------------------------------------------------------------------------

    PROCEDURE proc_load_wwo_common_asset_condition_set_q_master_key IS
    BEGIN
        execute immediate 'truncate table wwo_common_asset_condition_set_q_master_key';

        INSERT INTO wwo_common_asset_condition_set_q_master_key (
            raw_condition_q_id,
            class_id,
            class_description,
            raw_condition_q_no,
            raw_condition_q,
            src
        )
            WITH ds1 AS (
                SELECT DISTINCT
                    class_id,
                    class_description,
                    raw_condition_q_no,
                    raw_condition_q,
                    src

                FROM
                    wwo_common_asset_cleaned_no_calc_condition_q
            )
            SELECT
                ROWNUM,
                class_id,
                class_description,
                raw_condition_q_no,
                raw_condition_q,
                src
            FROM
                ds1
            ORDER BY
                class_description,
                raw_condition_q_no;

        COMMIT;
        MERGE INTO wwo_common_asset_cleaned_no_calc_condition_q t
        USING wwo_common_asset_condition_set_q_master_key s ON ( t.class_id = s.class_id
                                                              AND t.class_description = s.class_description
                                                              AND t.raw_condition_q_no = s.raw_condition_q_no
                                                              AND t.raw_condition_q = s.raw_condition_q 
                                                              AND t.src = s.src)
        WHEN MATCHED THEN UPDATE
        SET t.raw_condition_q_id = s.raw_condition_q_id;

        COMMIT;
    END;
    
-----------------------------------------------------------------------------------
    PROCEDURE proc_load_wwo_common_asset_parked IS
    BEGIN
        EXECUTE IMMEDIATE 'truncate table wwo_common_asset_parked';
        COMMIT;
        INSERT INTO wwo_common_asset_parked (
            asset_id,
            eam_class_id,
            eam_class_description,
            eam_class_id_known_flag,
            eam_commission_date,
            raw_tab1_class_id,
            raw_tab1_class_description,
            raw_tab1_class_id_known_flag,
            raw_tab2_class_id,
            raw_tab2_class_description,
            raw_tab2_class_id_known_flag,
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
                u.raw_tab1_class_id,
                u.raw_tab1_class_description,
                u.raw_tab1_class_id_known_flag,
                u.raw_tab2_class_id,
                u.raw_tab2_class_description,
                u.raw_tab2_class_id_known_flag,
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
                source src,
                status_comment
            FROM
                     wwo_common_asset_2b_cleaned r
                INNER JOIN wwo_common_asset_status u ON r.asset_id = u.asset_id
                                                        AND u.asset_status = 'P';

        COMMIT;
        UPDATE wwo_common_asset_parked
        SET
            data_unit = 11.2,
            class_type = 'NOT COUNTED';

        COMMIT;
        
     ------------------ update performed for PARKED unique 18 assets to move it to cleaned ------
    MERGE INTO wwo_common_asset_parked a
USING t_in_du_11_assets_detail_v b ON ( a.asset_id = b.asset_id )
WHEN MATCHED THEN UPDATE
SET a.eam_class_id = b.class_id,
    a.eam_class_description = b.wwo_class_description,
    a.cleaned_flag = 'Y',
    a.category = replace(b.category,'*',NULL);
    commit;
    
    ------------------ update performed for PARKED unique 18 assets to move it to cleaned ------
    END;

-----------------------------------------------------------------------------------

    PROCEDURE start_data_refresh IS
    BEGIN
        
        proc_load_wwo_segmnt_common_asset_class_master_final;
        proc_load_wwo_common_asset_status_upd_asset_status;
        proc_load_wwo_common_asset_parked;
        proc_load_wwo_common_asset_cleaned_no_calc;
        proc_load_wwo_common_asset_cleaned_no_calc_condition_q;
        proc_load_wwo_common_asset_condition_set_q_master_key;
        
    END;

END pkg_load_p1e_common_asset_data_final;

/
