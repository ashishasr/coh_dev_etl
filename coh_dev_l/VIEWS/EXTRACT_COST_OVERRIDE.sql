--------------------------------------------------------
--  DDL for View EXTRACT_COST_OVERRIDE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."EXTRACT_COST_OVERRIDE" ("CLASS_ID", "CLASS_DESCRIPTION", "CATEGORY_ID", "CATEGORY_DESCRIPTION", "REHAB_REPLACEMENT", "LABOR", "EQUIPMENT_COST", "GENERAL_CONDITION_5_PERCENT", "CONTRACT_OH_N_PROFIT_15_PERCENT", "ENG_CM_ADMIN_LEGAL_20_PERCENT", "SUB_TOTAL", "CONTIGENCY_25_PERCENT", "TOTAL_COST") AS SELECT
        class_id,
        class_description,
        category_id,
        category_description,
        rehab_replacement,
        CASE
            WHEN labor = 0 THEN
                '$ -'
            ELSE
                '$' || to_char(labor, 'FM9,999,999')
        END labor,
        CASE
            WHEN equipment_cost = 0 THEN
                '$ -'
            ELSE
                '$' || to_char(equipment_cost, 'FM9,999,999')
        END equipment_cost,
        CASE
            WHEN general_condition_5_percent = 0 THEN
                '$ -'
            ELSE
                '$' || to_char(general_condition_5_percent, 'FM9,999,999')
        END general_condition_5_percent,
        CASE
            WHEN contract_oh_n_profit_15_percent = 0 THEN
                '$ -'
            ELSE
                '$' || to_char(contract_oh_n_profit_15_percent, 'FM9,999,999')
        END contract_oh_n_profit_15_percent,
        CASE
            WHEN eng_cm_admin_legal_20_percent = 0 THEN
                '$ -'
            ELSE
                '$' || to_char(eng_cm_admin_legal_20_percent, 'FM9,999,999')
        END eng_cm_admin_legal_20_percent,
        CASE
            WHEN sub_total = 0 THEN
                '$ -'
            ELSE
                '$' || to_char(sub_total, 'FM9,999,999')
        END sub_total,
        CASE
            WHEN contigency_25_percent = 0 THEN
                '$ -'
            ELSE
                '$' || to_char(contigency_25_percent, 'FM9,999,999')
        END contigency_25_percent,
        CASE
            WHEN total_cost = 0 THEN
                '$ -'
            ELSE
                '$' || to_char(total_cost, 'FM9,999,999')
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
        coh_dev_t.wwo_cost_override_master
    WHERE
        class_id IN (
            SELECT
                class_id
            FROM
                active_class
            WHERE
                active_flag = 'Y'
        )
;
