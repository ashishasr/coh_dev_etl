--------------------------------------------------------
--  DDL for Package Body PKG_LOAD_P1A_MASTER_DATA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "COH_DEV_T"."PKG_LOAD_P1A_MASTER_DATA" AS
---------------------------------------------------------------------------
    PROCEDURE proc_load_wwo_class_description_master IS
    BEGIN
    /*
    Loads data for Class Description. The source extract is provided by Hexagon from EAM System.
    */
        execute immediate 'truncate table wwo_class_description_master';

        COMMIT;
        INSERT INTO wwo_class_description_master (
            class_id,
            class_description,
            organization
        )
            SELECT
                class_id,
                class_description,
                organization
            FROM
                t_in_class_description_v;

        COMMIT;
    END;
------------------------------------------------------------------------------

    PROCEDURE proc_load_dwo_class_condition_q_master IS
    BEGIN
    
    /*
    Loads the condition Questions that already have been implementated in Drinking Water (DWO). 
    This data is just used as reference for WWO comparision.
    */
    
    
        execute immediate 'truncate table dwo_class_condition_q_master';

        COMMIT;
        INSERT INTO dwo_class_condition_q_master (
            dwo_set_num,
            dwo_class_description,
            dwo_class_id,
            condition_q1,
            condition_q2,
            condition_q3,
            condition_q4,
            condition_q5,
            condition_q6,
            condition_q7,
            condition_q8,
            condition_q9,
            condition_q10
        )
            SELECT
                b.set_num,
                b.class_description,
                s.dwo_class_id,
                condition_q1,
                condition_q2,
                condition_q3,
                condition_q4,
                condition_q5,
                condition_q6,
                condition_q7,
                condition_q8,
                condition_q9,
                condition_q10
            FROM
                     t_in_dwo_condition_set_q_v a
                INNER JOIN t_in_dwo_condition_q_class_set_v b ON a.set_num = b.set_num
                LEFT JOIN t_in_wwo_class_segmentation_v    s ON s.dwo_class_description = b.class_description
            ORDER BY
                3,
                2;

        COMMIT;
    END;

------------------------------------------------------------------------------

    FUNCTION get_initial_reinvestment_action (
        in_max_no_of_rehabs NUMBER
    ) RETURN VARCHAR IS
        out_initial_reinvestment_action VARCHAR(100);
    BEGIN
        SELECT
            CASE
                WHEN in_max_no_of_rehabs <> 0 THEN
                    'Rehab'
                ELSE
                    'Replace'
            END
        INTO out_initial_reinvestment_action
        FROM
            dual;

        RETURN out_initial_reinvestment_action;
    END;
------------------------------------------------------------------------------------------------
    FUNCTION get_rehab_eul (
        in_estimated_useful_life NUMBER,
        in_rehab_revitalization  NUMBER
    ) RETURN NUMBER IS
        out_rehab_eul NUMBER;
    BEGIN
        SELECT
            in_estimated_useful_life * in_rehab_revitalization
        INTO out_rehab_eul
        FROM
            dual;

        RETURN out_rehab_eul;
    END;
----------------------------------------------------------------------------------
    FUNCTION get_max_potential_life (
        in_estimated_useful_life NUMBER,
        in_max_no_of_rehabs      NUMBER,
        in_rehab_eul             NUMBER
    ) RETURN NUMBER IS
        out_max_potential_life NUMBER;
    BEGIN
        SELECT
            in_estimated_useful_life + ( in_max_no_of_rehabs * in_rehab_eul )
        INTO out_max_potential_life
        FROM
            dual;

        RETURN out_max_potential_life;
    END;
-------------------------------------------------------------------------------------------------------
    PROCEDURE proc_load_wwo_asset_types_master IS
    BEGIN
    /*
    This is the master data ptovided by Hexagon at class level and has few calculated fields also which are 
    getting calculated here using functions.
    */
    
        execute immediate 'truncate table wwo_asset_types_master';

        COMMIT;
        --- original
        INSERT INTO wwo_asset_types_master (
            class_id,
            class_description,
            category_id,
            category_description,
            estimated_useful_life,
            max_no_of_rehabs,
            rehab_revitalization
        )
            SELECT
                class_id,
                class_description,
                category_id,
                category_description,
                estimated_useful_life,
                max_no_of_rehabs,
                rehab_revitalization
            FROM
                t_in_wwo_asset_types_v;

        COMMIT;
        
        -------------------------------- DU 9,10,11 -------------------------------------
        
--         INSERT INTO wwo_asset_types_master (
--            class_id,
--            class_description,
--            category_id,
--            du11_flag,
--            category_description
--        )
--        
--         SELECT distinct
--                class_id,
--                WWO_CLASS_DESCRIPTION,
--                CATEGORY,
--                'Y',category_description
--            FROM (
--               Select distinct CLASS_ID, WWO_CLASS_DESCRIPTION, CATEGORY, null category_description from T_IN_DU_11_ASSETS_DETAIL_V where category is not null
--                    union 
--                Select distinct eam_CLASS_ID, EAM_CLASS_DESCRIPTION, CATEGORY, category_description from T_IN_DU_9_10_CLASS_CATEGORY_INFO_V where category is not null
--                )
--;
--        COMMIT;
        
        ------------------------------- DU 9,10 ------------------------------------------
        

        
        
        
        UPDATE wwo_asset_types_master
        SET
            initial_reinvestment_action = pkg_load_p1a_master_data.get_initial_reinvestment_action(max_no_of_rehabs),
            cip_recommended_reinvestment_action = pkg_load_p1a_master_data.get_initial_reinvestment_action(max_no_of_rehabs);

        COMMIT;
        UPDATE wwo_asset_types_master
        SET
            rehab_eul = pkg_load_p1a_master_data.get_rehab_eul(estimated_useful_life, rehab_revitalization);

        COMMIT;
        UPDATE wwo_asset_types_master
        SET
            max_potential_life = pkg_load_p1a_master_data.get_max_potential_life(estimated_useful_life, max_no_of_rehabs, rehab_eul);

        COMMIT;
    END;
    
----------------------------------------------------------------------------
    PROCEDURE proc_load_wwo_condition_set_q_master IS
    BEGIN
    /*
    These are the condition questions provided by Hexagon for each class.    
    */
    
        execute immediate 'truncate table wwo_condition_set_q_master';

        COMMIT;
        INSERT INTO wwo_condition_set_q_master (
            organization,
            class_id,
            class_description,
            condition_q1,
            condition_q2,
            condition_q3,
            condition_q4,
            condition_q5,
            condition_q6,
            condition_q7,
            condition_q8,
            condition_q9,
            condition_q10,
            comments,
            matching_with_dwo
        )
            SELECT
                organization,
                class_id,
                class_description,
                condition_q1,
                condition_q2,
                condition_q3,
                condition_q4,
                condition_q5,
                condition_q6,
                condition_q7,
                condition_q8,
                condition_q9,
                condition_q10,
                comments,
                matching_with_dwo
            FROM
                t_in_wwo_condition_set_q_v;

        COMMIT;
    END;
    
-----------------------------------------------------------------------------

    PROCEDURE proc_load_wwo_condition_set_q_master_transpose IS
    BEGIN
    /*
    A transpose is done to bring the condition questions from column level to row level
    */
    
        execute immediate 'truncate table wwo_condition_set_q_master_transpose';

        INSERT INTO wwo_condition_set_q_master_transpose (
            organization,
            class_id,
            class_description,
            matching_with_dwo,
            ref_condition_q_no,
            ref_condition_q
        )
            SELECT
                organization,
                class_id,
                class_description,
                matching_with_dwo,
                condition_q_no,
                condition_q
            FROM
                t_in_wwo_condition_set_q_v UNPIVOT ( condition_q
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
                class_id,
                condition_q_no;

        COMMIT;
    END;
-----------------------------------------------------------------------------

    PROCEDURE proc_load_wwo_condition_set_q_master_key IS
    BEGIN
    
    /*A unique ID is generated for each standard / reference condition Q belonging to a class*/
        execute immediate 'truncate table wwo_condition_set_q_master_key';

        COMMIT;
        INSERT INTO wwo_condition_set_q_master_key (
            ref_condition_q_id,
            class_id,
            class_description,
            ref_condition_q_no,
            ref_condition_q
        )
            WITH ds1 AS (
                SELECT DISTINCT
                    class_id,
                    class_description,
                    ref_condition_q_no,
                    ref_condition_q
                FROM
                    wwo_condition_set_q_master_transpose
            )
            SELECT
                ROWNUM,
                class_id,
                class_description,
                ref_condition_q_no,
                ref_condition_q
            FROM
                ds1
            ORDER BY
                class_description,
                ref_condition_q_no;

        COMMIT;
        
        /*The ID generated for each standard condition question is updated back in the transpose table*/
        
        MERGE INTO wwo_condition_set_q_master_transpose t
        USING wwo_condition_set_q_master_key s ON ( t.class_id = s.class_id
                                                    AND t.class_description = s.class_description
                                                    AND t.ref_condition_q_no = s.ref_condition_q_no
                                                    AND t.ref_condition_q = s.ref_condition_q )
        WHEN MATCHED THEN UPDATE
        SET t.ref_condition_q_id = s.ref_condition_q_id;

        COMMIT;
    END;

-----------------------------------------------------------------------------

    PROCEDURE proc_load_cost_override_master IS
    BEGIN
        execute immediate 'truncate table wwo_cost_override_master';

        COMMIT;
        INSERT INTO wwo_cost_override_master (
            class_id,
            class_description,
            category_id,
            category_description,
            rehab_replacement,
            labor,
            equipment_cost,
            general_condition_5_percent,
            contract_oh_n_profit_15_percent,
            eng_cm_admin_legal_20_percent
        )
            SELECT
                class_id,
                class_description,
                category_id,
                category_description,
                rehab_replacement,
                labor,
                equipment_cost,
                0.05 * ( nvl(labor, 0) + nvl(equipment_cost, 0) ),
                0.15 * ( nvl(labor, 0) + nvl(equipment_cost, 0) ),
                0.2 * ( nvl(labor, 0) + nvl(equipment_cost, 0) )
            FROM
                t_in_wwo_cost_override_v;

        COMMIT;
        
        ------------------- DU , 9,10,11
--         INSERT INTO wwo_cost_override_master (
--            class_id,
--            class_description,
--            category_id,
--            category_description,
--            rehab_replacement,
--            labor,
--            equipment_cost,
--            general_condition_5_percent,
--            contract_oh_n_profit_15_percent,
--            eng_cm_admin_legal_20_percent,
--            du11_flag
--        )
--            SELECT distinct
--                class_id,
--                WWO_CLASS_DESCRIPTION,
--                category,
--                category_description,
--                null,
--                null,
--                null,
--                null,
--                null,
--                null,
--                'Y'
--            FROM (
--                 Select distinct CLASS_ID, WWO_CLASS_DESCRIPTION, CATEGORY, null category_description from T_IN_DU_11_ASSETS_DETAIL_V where category is not null
--            union 
--            Select distinct eam_CLASS_ID, EAM_CLASS_DESCRIPTION, CATEGORY, category_description from T_IN_DU_9_10_CLASS_CATEGORY_INFO_V where category is not null )
--            commit;
        ---------------------
        
        
        UPDATE wwo_cost_override_master
        SET
            sub_total = nvl(labor, 0) + nvl(equipment_cost, 0) + nvl(general_condition_5_percent, 0) + nvl(contract_oh_n_profit_15_percent
            , 0) + nvl(eng_cm_admin_legal_20_percent, 0);

        COMMIT;
        UPDATE wwo_cost_override_master
        SET
            contigency_25_percent = sub_total * 0.25;

        COMMIT;
        UPDATE wwo_cost_override_master
        SET
            total_cost = CEIL((sub_total + contigency_25_percent) / 100) * 100;

        COMMIT;
        UPDATE wwo_cost_override_master
        SET
            cost_override = CEIL((sub_total + contigency_25_percent) / 100) * 100;

        COMMIT;
    END;
    
-----------------------------------------------------------------------------
    PROCEDURE proc_load_wwo_eam_system_extract_master IS
    BEGIN
        execute immediate 'truncate table wwo_eam_system_extract_master';

        COMMIT;
        INSERT INTO wwo_eam_system_extract_master (
            asset_id,
            class_id,
            status,
            commission_date,
            category
        )
            SELECT
                asset_id,
                class_id,
                status,
                commission_date,
                category
            FROM
                t_in_wwo_eam_system_extract_v;

        COMMIT;
    END;

------------------------------------------------------------------------------

    PROCEDURE proc_load_wwo_matrix_answers_master IS
    BEGIN
        execute immediate 'truncate table wwo_matrix_answers_master';

        COMMIT;
        INSERT INTO wwo_matrix_answers_master (
            matrix,
            matrix_key,
            matrix_value,
            matrix_answers
        )
            SELECT
                matrix,
                substr(matrix_answers, 1, 1) matrix_key,
                substr(matrix_answers, 5)    matrix_value,
                matrix_answers
            FROM
                t_in_wwo_matrix_answers_v;

        COMMIT;
    END;
    
-----------------------------------------------------------------------------

    PROCEDURE proc_load_wwo_raw_tab1_master_data IS
    BEGIN
        execute immediate 'truncate table wwo_raw_tab1_master_data';

        COMMIT;
        INSERT INTO wwo_raw_tab1_master_data (
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
            cof_service_priority
        )
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
                cof_service_priority
            FROM
                t_in_wwo_raw_tab1_v;

        COMMIT;
    END;
-----------------------------------------------------------------------------
    PROCEDURE proc_load_wwo_raw_tab2_master_data IS
    BEGIN
        execute immediate 'truncate table wwo_raw_tab2_master_data';

        INSERT INTO wwo_raw_tab2_master_data (
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
            cof_service_priority
        )
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
                cof_service_priority
            FROM
                t_in_wwo_raw_tab2_v;

        COMMIT;
    END;
    
-----------------------------------------------------------------------------
    PROCEDURE proc_load_wwo_record_discarded_master IS
    BEGIN
        execute immediate 'truncate table wwo_record_discarded_master';

        COMMIT;
        INSERT INTO wwo_record_discarded_master (
            attribute_a1,
            asset,
            class_id,
            class,
            status,
            assessment_date,
            lof_capacity,
            lof_reliability,
            lof_om,
            lof_obsolescence,
            lof_redundancy,
            lof_erul,
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
            src
        )
            SELECT
                attribute_a1,
                asset,
                class_id,
                class,
                status,
                assessment_date,
                lof_capacity,
                lof_reliability,
                lof_om,
                lof_obsolescence,
                lof_redundancy,
                lof_erul,
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
                'TAB1' src
            FROM
                coh_dev_e.e_wwo_raw_tab1_v
            WHERE
                attribute_a1 IS NULL
            UNION ALL
            SELECT
                attribute_a1,
                asset,
                class_id,
                class,
                status,
                assessment_date,
                lof_capacity,
                lof_reliability,
                lof_om,
                lof_obsolescence,
                lof_redundancy,
                lof_erul,
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
                'TAB2' src
            FROM
                coh_dev_e.e_wwo_raw_tab2_v
            WHERE
                attribute_a1 IS NULL;

        COMMIT;
    END;

-----------------------------------------------------------------------------
    PROCEDURE start_data_refresh IS
    BEGIN
        proc_load_wwo_class_description_master;
        proc_load_dwo_class_condition_q_master;
        proc_load_wwo_asset_types_master;
        proc_load_wwo_condition_set_q_master;
        proc_load_wwo_condition_set_q_master_transpose;
        proc_load_wwo_condition_set_q_master_key;
        proc_load_cost_override_master;
        proc_load_wwo_eam_system_extract_master;
        proc_load_wwo_matrix_answers_master;
        proc_load_wwo_raw_tab1_master_data;
        proc_load_wwo_raw_tab2_master_data;
        proc_load_wwo_record_discarded_master;
    END;

END pkg_load_p1a_master_data;

/
