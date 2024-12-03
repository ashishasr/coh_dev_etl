--------------------------------------------------------
--  DDL for View MINUS_ASSET_REGISTER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_QA"."MINUS_ASSET_REGISTER" ("ASSET_ID", "CLASS_ID", "CLASS_DESCRIPTION", "CATEGORY_ID", "CATEGORY_DESCRIPTION", "COMMISSION_DATE", "MIN_SYSTEM_COMMISSION_YEAR", "CONDITION_Q1", "CONDITION_A1", "CONDITION_Q2", "CONDITION_A2", "CONDITION_Q3", "CONDITION_A3", "CONDITION_Q4", "CONDITION_A4", "CONDITION_Q5", "CONDITION_A5", "CONDITION_Q6", "CONDITION_A6", "CONDITION_Q7", "CONDITION_A7", "CONDITION_Q8", "CONDITION_A8", "CONDITION_Q9", "CONDITION_A9", "CONDITION_Q10", "CONDITION_A10", "CONDITION_SCORE", "CONDITION_RATING", "PERFORMANCE_CAPACITY", "PERFORMANCE_RELIABILITY", "PERFORMANCE_OM", "PERFORMANCE_OBSOLESCENCE", "PERFORMANCE_REDUNDANCY", "PERFORMANCE_SCORE", "PERFORMANCE_RATING", "LOF_SCORE", "LOF_RATING", "REDUNDANCY_FACTOR_REVISED", "ESTIMATED_USEFUL_LIFE", "AGE", "LIFE_REMAINING", "PERCENT_LIFE_CONSUMED_NUMBER", "CONDITION_ADJUSTED_USEFUL_LIFE", "CONDITION_ADJUSTED_LIFE_REMAINING", "CONDITION_ADJUSTED_PERCENT_LIFE_CONSUMED_NUMBER", "PREDICTED_REPLACEMENT_YEAR", "PREDICTED_CIP_YEAR", "COF_REPLACEMENT_COST", "COF_OM_IMPACTS", "COF_LEVEL_OF_SERVICE", "COF_HEALTH_AND_SAFETY", "COF_PERMIT_COMPLIANCE", "COF_RESPONSE_TIME", "COF_SERVICE_PRIORITY", "COF_SCORE", "COF_RATING", "RISK_BASELINE_VALUE", "BR1", "BR2", "BR3", "CIP_RECOMMENDED_REINVESTMENT_ACTION", "COST_OVERRIDE", "REHAB_EUL", "NO_OF_REHAB", "REPLACEMENT_EUL", "FIRST_ACTION", "FIRST_ACTION_TIMEFRAME_BR_1", "FIRST_ACTION_TIMEFRAME_BR_2", "FIRST_ACTION_TIMEFRAME_BR_3", "FIRST_ACTION_COST", "SECOND_ACTION", "SECOND_ACTION_TIMEFRAME_BR_1", "SECOND_ACTION_TIMEFRAME_BR_2", "SECOND_ACTION_TIMEFRAME_BR_3", "SECOND_ACTION_COST", "THIRD_ACTION", "THIRD_ACTION_TIMEFRAME_BR_1", "THIRD_ACTION_TIMEFRAME_BR_2", "THIRD_ACTION_TIMEFRAME_BR_3", "THIRD_ACTION_COST", "FOURTH_ACTION", "FOURTH_ACTION_TIMEFRAME_BR_1", "FOURTH_ACTION_TIMEFRAME_BR_2", "FOURTH_ACTION_TIMEFRAME_BR_3", "FOURTH_ACTION_COST", "TIMEFRAME") AS SELECT
    asset_id,
    class_id,
    class_description,
    category_id,
    category_description,
    commission_date,
    min_system_commission_year,
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
    condition_score,
    condition_rating,
    performance_capacity,
    performance_reliability,
    performance_om,
    performance_obsolescence,
    performance_redundancy,
    performance_score,
    performance_rating,
    lof_score,
    lof_rating,
    redundancy_factor_revised,
    estimated_useful_life,
    age,
    life_remaining,
    percent_life_consumed_number,
    condition_adjusted_useful_life,
    condition_adjusted_life_remaining,
    condition_adjusted_percent_life_consumed_number,
    predicted_replacement_year,
    predicted_cip_year,
    cof_replacement_cost,
    cof_om_impacts,
    cof_level_of_service,
    cof_health_and_safety,
    cof_permit_compliance,
    cof_response_time,
    cof_service_priority,
    cof_score,
    cof_rating,
    risk_baseline_value,
    br1,
    br2,
    br3,
    cip_recommended_reinvestment_action,
    cost_override,
    rehab_eul,
    no_of_rehab,
    replacement_eul,
    first_action,
    first_action_timeframe_br_1,
    first_action_timeframe_br_2,
    first_action_timeframe_br_3,
    first_action_cost,
    second_action,
    second_action_timeframe_br_1,
    second_action_timeframe_br_2,
    second_action_timeframe_br_3,
    second_action_cost,
    third_action,
    third_action_timeframe_br_1,
    third_action_timeframe_br_2,
    third_action_timeframe_br_3,
    third_action_cost,
    fourth_action,
    fourth_action_timeframe_br_1,
    fourth_action_timeframe_br_2,
    fourth_action_timeframe_br_3,
    fourth_action_cost,
    timeframe
FROM
    template_asset_register
minus
SELECT
    asset_id,
    class_id,
    class_description,
    category_id,
    category_description,
    commission_date,
    min_system_commission_year,
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
    condition_score,
    condition_rating,
    performance_capacity,
    performance_reliability,
    performance_om,
    performance_obsolescence,
    performance_redundancy,
    performance_score,
    performance_rating,
    lof_score,
    lof_rating,
    redundancy_factor_revised,
    estimated_useful_life,
    age,
    life_remaining,
    percent_life_consumed_number,
    condition_adjusted_useful_life,
    condition_adjusted_life_remaining,
    condition_adjusted_percent_life_consumed_number,
    predicted_replacement_year,
    predicted_cip_year,
    cof_replacement_cost,
    cof_om_impacts,
    cof_level_of_service,
    cof_health_and_safety,
    cof_permit_compliance,
    cof_response_time,
    cof_service_priority,
    cof_score,
    cof_rating,
    risk_baseline_value,
    br1,
    br2,
    br3,
    cip_recommended_reinvestment_action,
    cost_override,
    rehab_eul,
    no_of_rehab,
    replacement_eul,
    first_action,
    first_action_timeframe_br_1,
    first_action_timeframe_br_2,
    first_action_timeframe_br_3,
    first_action_cost,
    second_action,
    second_action_timeframe_br_1,
    second_action_timeframe_br_2,
    second_action_timeframe_br_3,
    second_action_cost,
    third_action,
    third_action_timeframe_br_1,
    third_action_timeframe_br_2,
    third_action_timeframe_br_3,
    third_action_cost,
    fourth_action,
    fourth_action_timeframe_br_1,
    fourth_action_timeframe_br_2,
    fourth_action_timeframe_br_3,
    fourth_action_cost,
    timeframe
FROM
    extract_asset_register
UNION ALL

SELECT
    asset_id,
    class_id,
    class_description,
    category_id,
    category_description,
    commission_date,
    min_system_commission_year,
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
    condition_score,
    condition_rating,
    performance_capacity,
    performance_reliability,
    performance_om,
    performance_obsolescence,
    performance_redundancy,
    performance_score,
    performance_rating,
    lof_score,
    lof_rating,
    redundancy_factor_revised,
    estimated_useful_life,
    age,
    life_remaining,
    percent_life_consumed_number,
    condition_adjusted_useful_life,
    condition_adjusted_life_remaining,
    condition_adjusted_percent_life_consumed_number,
    predicted_replacement_year,
    predicted_cip_year,
    cof_replacement_cost,
    cof_om_impacts,
    cof_level_of_service,
    cof_health_and_safety,
    cof_permit_compliance,
    cof_response_time,
    cof_service_priority,
    cof_score,
    cof_rating,
    risk_baseline_value,
    br1,
    br2,
    br3,
    cip_recommended_reinvestment_action,
    cost_override,
    rehab_eul,
    no_of_rehab,
    replacement_eul,
    first_action,
    first_action_timeframe_br_1,
    first_action_timeframe_br_2,
    first_action_timeframe_br_3,
    first_action_cost,
    second_action,
    second_action_timeframe_br_1,
    second_action_timeframe_br_2,
    second_action_timeframe_br_3,
    second_action_cost,
    third_action,
    third_action_timeframe_br_1,
    third_action_timeframe_br_2,
    third_action_timeframe_br_3,
    third_action_cost,
    fourth_action,
    fourth_action_timeframe_br_1,
    fourth_action_timeframe_br_2,
    fourth_action_timeframe_br_3,
    fourth_action_cost,
    timeframe
FROM
    extract_asset_register
minus
SELECT
    asset_id,
    class_id,
    class_description,
    category_id,
    category_description,
    commission_date,
    min_system_commission_year,
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
    condition_score,
    condition_rating,
    performance_capacity,
    performance_reliability,
    performance_om,
    performance_obsolescence,
    performance_redundancy,
    performance_score,
    performance_rating,
    lof_score,
    lof_rating,
    redundancy_factor_revised,
    estimated_useful_life,
    age,
    life_remaining,
    percent_life_consumed_number,
    condition_adjusted_useful_life,
    condition_adjusted_life_remaining,
    condition_adjusted_percent_life_consumed_number,
    predicted_replacement_year,
    predicted_cip_year,
    cof_replacement_cost,
    cof_om_impacts,
    cof_level_of_service,
    cof_health_and_safety,
    cof_permit_compliance,
    cof_response_time,
    cof_service_priority,
    cof_score,
    cof_rating,
    risk_baseline_value,
    br1,
    br2,
    br3,
    cip_recommended_reinvestment_action,
    cost_override,
    rehab_eul,
    no_of_rehab,
    replacement_eul,
    first_action,
    first_action_timeframe_br_1,
    first_action_timeframe_br_2,
    first_action_timeframe_br_3,
    first_action_cost,
    second_action,
    second_action_timeframe_br_1,
    second_action_timeframe_br_2,
    second_action_timeframe_br_3,
    second_action_cost,
    third_action,
    third_action_timeframe_br_1,
    third_action_timeframe_br_2,
    third_action_timeframe_br_3,
    third_action_cost,
    fourth_action,
    fourth_action_timeframe_br_1,
    fourth_action_timeframe_br_2,
    fourth_action_timeframe_br_3,
    fourth_action_cost,
    timeframe
FROM
    template_asset_register
;
