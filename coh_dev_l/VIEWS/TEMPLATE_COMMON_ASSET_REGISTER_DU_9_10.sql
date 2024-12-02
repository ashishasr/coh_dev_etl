--------------------------------------------------------
--  DDL for View TEMPLATE_COMMON_ASSET_REGISTER_DU_9_10
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."TEMPLATE_COMMON_ASSET_REGISTER_DU_9_10" ("ASSET_ID", "CLASS_ID", "CLASS_DESCRIPTION", "CATEGORY_ID", "CATEGORY_DESCRIPTION", "COMMISSION_DATE", "MIN_SYSTEM_COMMISSION_YEAR", "CONDITION_Q1", "CONDITION_A1", "CONDITION_Q2", "CONDITION_A2", "CONDITION_Q3", "CONDITION_A3", "CONDITION_Q4", "CONDITION_A4", "CONDITION_Q5", "CONDITION_A5", "CONDITION_Q6", "CONDITION_A6", "CONDITION_Q7", "CONDITION_A7", "CONDITION_Q8", "CONDITION_A8", "CONDITION_Q9", "CONDITION_A9", "CONDITION_Q10", "CONDITION_A10", "CONDITION_SCORE", "CONDITION_RATING", "PERFORMANCE_CAPACITY", "PERFORMANCE_RELIABILITY", "PERFORMANCE_OM", "PERFORMANCE_OBSOLESCENCE", "PERFORMANCE_REDUNDANCY", "PERFORMANCE_SCORE", "PERFORMANCE_RATING", "LOF_SCORE", "LOF_RATING", "REDUNDANCY_FACTOR_REVISED", "ESTIMATED_USEFUL_LIFE", "AGE", "LIFE_REMAINING", "PERCENT_LIFE_CONSUMED_NUMBER", "CONDITION_ADJUSTED_USEFUL_LIFE", "CONDITION_ADJUSTED_LIFE_REMAINING", "CONDITION_ADJUSTED_PERCENT_LIFE_CONSUMED_NUMBER", "PREDICTED_REPLACEMENT_YEAR", "PREDICTED_CIP_YEAR", "COF_REPLACEMENT_COST", "COF_OM_IMPACTS", "COF_LEVEL_OF_SERVICE", "COF_HEALTH_AND_SAFETY", "COF_PERMIT_COMPLIANCE", "COF_RESPONSE_TIME", "COF_SERVICE_PRIORITY", "COF_SCORE", "COF_RATING", "RISK_BASELINE_VALUE", "BR1", "BR2", "BR3", "CIP_RECOMMENDED_REINVESTMENT_ACTION", "COST_OVERRIDE", "REHAB_EUL", "NO_OF_REHAB", "REPLACEMENT_EUL", "FIRST_ACTION", "FIRST_ACTION_TIMEFRAME_BR_1", "FIRST_ACTION_TIMEFRAME_BR_2", "FIRST_ACTION_TIMEFRAME_BR_3", "FIRST_ACTION_COST", "SECOND_ACTION", "SECOND_ACTION_TIMEFRAME_BR_1", "SECOND_ACTION_TIMEFRAME_BR_2", "SECOND_ACTION_TIMEFRAME_BR_3", "SECOND_ACTION_COST", "THIRD_ACTION", "THIRD_ACTION_TIMEFRAME_BR_1", "THIRD_ACTION_TIMEFRAME_BR_2", "THIRD_ACTION_TIMEFRAME_BR_3", "THIRD_ACTION_COST", "FOURTH_ACTION", "FOURTH_ACTION_TIMEFRAME_BR_1", "FOURTH_ACTION_TIMEFRAME_BR_2", "FOURTH_ACTION_TIMEFRAME_BR_3", "FOURTH_ACTION_COST", "TIMEFRAME") AS SELECT
        a1.asset_id,
        a1.class_id,
        a1.class_description,
        nvl(nvl(a1.category_id, m.category),'D'|| a1.class_id|| '[WWO]') category_id,
        case when (nvl(nvl(a1.category_id, m.category),'D'|| a1.class_id|| '[WWO]')) like 'D%' then 
        nvl(a1.category_description,'DWO SOURCED' || ' ' || a1.class_description)
        else null end,
        to_char(a1.commission_date, 'MM/DD/YYYY'),
        NULL,
        b2.condition_q1,
        b2.condition_a1,
        b2.condition_q2,
        b2.condition_a2,
        b2.condition_q3,
        b2.condition_a3,
        b2.condition_q4,
        b2.condition_a4,
        b2.condition_q5,
        b2.condition_a5,
        b2.condition_q6,
        b2.condition_a6,
        b2.condition_q7,
        b2.condition_a7,
        b2.condition_q8,
        b2.condition_a8,
        b2.condition_q9,
        b2.condition_a9,
        b2.condition_q10,
        b2.condition_a10,
        NULL,
        NULL,
        c3.performance_capacity,
        c3.performance_reliability,
        c3.performance_om,
        c3.performance_obsolescence,
        c3.performance_redundancy,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        e5.cof_replacement_cost,
        e5.cof_om_impacts,
        e5.cof_level_of_service,
        e5.cof_health_and_safety,
        e5.cof_permit_compliance,
        e5.cof_response_time,
        e5.cof_service_priority,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL
    FROM
             coh_dev_t.load_common_asset_cleaned_1_asset_info a1
        INNER JOIN coh_dev_t.load_common_asset_cleaned_2_condition_q_info   b2 ON a1.asset_id = b2.asset_id
                                                                                AND a1.class_id IN (
            SELECT
                class_id
            FROM
                active_class_cmn_du_9_10
            WHERE
                active_flag = 'Y'
        )
                                                                                AND a1.asset_id NOT IN (
            SELECT
                asset_id
            FROM
                basin_class
        )
        LEFT JOIN coh_dev_t.load_common_asset_cleaned_3_performance_info   c3 ON a1.asset_id = c3.asset_id
        LEFT JOIN coh_dev_t.load_common_asset_cleaned_6_perf_cond_lof_info f6 ON a1.asset_id = f6.asset_id
        LEFT JOIN coh_dev_t.load_common_asset_cleaned_4_amc_info           d4 ON a1.asset_id = d4.asset_id
        LEFT JOIN coh_dev_t.load_common_asset_cleaned_5_cof_info           e5 ON a1.asset_id = e5.asset_id
        LEFT JOIN coh_dev_t.load_common_asset_cleaned_7_brr_info           g7 ON a1.asset_id = g7.asset_id
        LEFT JOIN coh_dev_t.wwo_asset_types_master                         asset_types ON asset_types.class_id = a1.class_id
                                                                  AND asset_types.category_id = a1.category_id
        LEFT JOIN coh_dev_t.wwo_cost_override_master                       cost_over ON cost_over.class_id = a1.class_id
                                                                  AND cost_over.category_id = a1.category_id
        LEFT JOIN coh_dev_t.load_common_asset_cleaned_8_cpal_info          h8 ON a1.asset_id = h8.asset_id
        LEFT JOIN coh_dev_t.wwo_eam_system_extract_master                  m ON m.asset_id = a1.asset_id
    ORDER BY
        a1.class_description,
        a1.asset_id
;
