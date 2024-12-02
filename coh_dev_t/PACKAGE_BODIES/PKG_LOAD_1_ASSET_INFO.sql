--------------------------------------------------------
--  DDL for Package Body PKG_LOAD_1_ASSET_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "COH_DEV_T"."PKG_LOAD_1_ASSET_INFO" AS

    FUNCTION get_min_system_commision_yr (
        in_commission_date DATE
    ) RETURN NUMBER IS
        out_min_system_commision_yr NUMBER;
    BEGIN
        SELECT
            nvl(TO_NUMBER(EXTRACT(YEAR FROM in_commission_date)),
                '1980')
        INTO out_min_system_commision_yr
        FROM
            dual;

        RETURN out_min_system_commision_yr;
    END;
--------------------------------------------------------------------------

---------------------------------------------------------------------------
    PROCEDURE proc_load_unq_asset_cleaned_1_asset_info IS
    BEGIN
        execute immediate 'truncate table load_unq_asset_cleaned_1_asset_info';

        COMMIT;
        
    -- these are assets from DU 1 to 10 and assets from du 11 where category is null from the data provided by Hexagon    
        INSERT INTO load_unq_asset_cleaned_1_asset_info (
            asset_id,
            class_id,
            class_description,
            commission_date,
            category_id,
            category_description,
            estimated_useful_life,
            max_no_of_rehabs,
            rehab_revitalization_percent
        )
            SELECT
                asset_id,
                eam_class_id,
                eam_class_description,
                eam_commission_date,
                at.category_id,
                at.category_description,
                at.estimated_useful_life,
                at.max_no_of_rehabs,
                at.rehab_revitalization
            FROM
                     wwo_unq_asset_cleaned_no_calc nc 
                 LEFT JOIN WWO_ASSET_TYPES_MASTER at ON nc.eam_class_id = at.class_id and du11_flag = 'N'
                where asset_id not in (Select asset_id from T_IN_DU_11_ASSETS_DETAIL_V where category is not null); -- new added
        COMMIT;
        -------- for DU 11---------------------------------
         INSERT INTO load_unq_asset_cleaned_1_asset_info (
            asset_id,
            class_id,
            class_description,
            commission_date,
            category_id,
            category_description,
            estimated_useful_life,
            max_no_of_rehabs,
            rehab_revitalization_percent,
            du11_flag
        )
            SELECT
                nc.asset_id,
                eam_class_id,
                eam_class_description,
                eam_commission_date,
                nc.category,
                at.category_description,
                at.estimated_useful_life,
                at.max_no_of_rehabs,
                at.rehab_revitalization,
                'Y'
            FROM
                      wwo_unq_asset_cleaned_no_calc nc 
                LEFT JOIN WWO_ASSET_TYPES_MASTER at ON nc.eam_class_id = at.class_id and nc.category = at.category_id and du11_flag = 'Y'
                inner JOIN T_IN_DU_11_ASSETS_DETAIL_V at ON nc.asset_id = at.asset_id and at.category is not null; -- du11 records will come 
        commit;
        
        ----------------------------------------------------------------------------------
        
        UPDATE load_unq_asset_cleaned_1_asset_info
        SET
            min_system_commission_year = get_min_system_commision_yr(commission_date);

        COMMIT;
    END;

    PROCEDURE start_data_refresh IS
    BEGIN
        proc_load_unq_asset_cleaned_1_asset_info;
    END start_data_refresh;

END pkg_load_1_asset_info;

/
