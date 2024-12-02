--------------------------------------------------------
--  DDL for View EXTRACT_COST_OVERRIDE_DU_9_10
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."EXTRACT_COST_OVERRIDE_DU_9_10" ("CLASS_ID", "CLASS_DESCRIPTION", "CATEGORY_ID", "CATEGORY_DESCRIPTION", "REHAB_REPLACEMENT", "LABOR", "EQUIPMENT_COST", "GENERAL_CONDITION_5_PERCENT", "CONTRACT_OH_N_PROFIT_15_PERCENT", "ENG_CM_ADMIN_LEGAL_20_PERCENT", "SUB_TOTAL", "CONTIGENCY_25_PERCENT", "TOTAL_COST") AS SELECT DISTINCT
        a.class_id,
        a.class_description,
        a.category_id,
        a.category_description,
        a.rehab_replacement,
        CASE
            WHEN a.labor = 0 THEN
                '$ -'
            ELSE
                '$'
                || to_char(a.labor, 'FM9,999,999')
        END labor,
        CASE
            WHEN a.equipment_cost = 0 THEN
                '$ -'
            ELSE
                '$'
                || to_char(a.equipment_cost, 'FM9,999,999')
        END equipment_cost,
        CASE
            WHEN a.general_condition_5_percent = 0 THEN
                '$ -'
            ELSE
                '$'
                || to_char(a.general_condition_5_percent, 'FM9,999,999')
        END general_condition_5_percent,
        CASE
            WHEN a.contract_oh_n_profit_15_percent = 0 THEN
                '$ -'
            ELSE
                '$'
                || to_char(a.contract_oh_n_profit_15_percent, 'FM9,999,999')
        END contract_oh_n_profit_15_percent,
        CASE
            WHEN a.eng_cm_admin_legal_20_percent = 0 THEN
                '$ -'
            ELSE
                '$'
                || to_char(a.eng_cm_admin_legal_20_percent, 'FM9,999,999')
        END eng_cm_admin_legal_20_percent,
        CASE
            WHEN a.sub_total = 0 THEN
                '$ -'
            ELSE
                '$'
                || to_char(a.sub_total, 'FM9,999,999')
        END sub_total,
        CASE
            WHEN a.contigency_25_percent = 0 THEN
                '$ -'
            ELSE
                '$'
                || to_char(a.contigency_25_percent, 'FM9,999,999')
        END contigency_25_percent,
        CASE
            WHEN a.total_cost = 0 THEN
                '$ -'
            ELSE
                '$'
                || to_char(a.total_cost, 'FM9,999,999')
        END total_cost   
        --'$' || TO_CHAR(labor, 'FM9,999'),
        --'$' || TO_CHAR(equipment_cost, 'FM9,999'),
        --'$' || TO_CHAR(general_condition_5_percent, 'FM9,999'),
        --'$' || TO_CHAR(contract_oh_n_profit_15_percent, 'FM9,999'),
        --'$' || TO_CHAR(eng_cm_admin_legal_20_percent, 'FM9,999'),
        --'$' || TO_CHAR(sub_total, 'FM9,999'),
        --'$' || TO_CHAR(contigency_25_percent, 'FM9,999'),
        --'$' || TO_CHAR(total_cost, 'FM9,999')
    FROM
             coh_dev_t.wwo_cost_override_master a
        INNER JOIN extract_asset_register_du_9_10 b ON a.class_id = b.class_id
                                                       AND a.category_id = b.category_id
;
