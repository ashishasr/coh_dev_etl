--------------------------------------------------------
--  DDL for View T_IN_WWO_RAW_TAB2_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_T"."T_IN_WWO_RAW_TAB2_V" ("ASSET_ID", "CLASS_ID", "CLASS_DESCRIPTION", "STATUS", "COMMISSION_DATE", "PERFORMANCE_CAPACITY", "PERFORMANCE_RELIABILITY", "PERFORMANCE_OM", "PERFORMANCE_OBSOLESCENCE", "PERFORMANCE_REDUNDANCY", "PERFORMANCE_ERUL", "CONDITION_Q1", "CONDITION_A1", "CONDITION_Q2", "CONDITION_A2", "CONDITION_Q3", "CONDITION_A3", "CONDITION_Q4", "CONDITION_A4", "CONDITION_Q5", "CONDITION_A5", "CONDITION_Q6", "CONDITION_A6", "CONDITION_Q7", "CONDITION_A7", "CONDITION_Q8", "CONDITION_A8", "CONDITION_Q9", "CONDITION_A9", "CONDITION_Q10", "CONDITION_A10", "COF_REPLACEMENT_COST", "COF_OM_IMPACTS", "COF_LEVEL_OF_SERVICE", "COF_HEALTH_AND_SAFETY", "COF_PERMIT_COMPLIANCE", "COF_RESPONSE_TIME", "COF_SERVICE_PRIORITY") AS SELECT
        attribute_a1, -- asset_id
        class_id,
        class,
        status,
        assessment_date, -- commission date
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
        cof_service_priority
    FROM
        coh_dev_e.e_wwo_raw_tab2_v
;
  GRANT READ ON "COH_DEV_T"."T_IN_WWO_RAW_TAB2_V" TO "COH_DEV_L";
