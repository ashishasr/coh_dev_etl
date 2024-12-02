--------------------------------------------------------
--  DDL for View CHK_ERR_CONDITION_Q
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."CHK_ERR_CONDITION_Q" ("CLASS_ID", "CONDITION_Q1", "CONDITION_Q2", "CONDITION_Q3", "CONDITION_Q4", "CONDITION_Q5", "CONDITION_Q6", "CONDITION_Q7", "CONDITION_Q8", "CONDITION_Q9", "CONDITION_Q10") AS SELECT DISTINCT
        class_id,
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
        extract_asset_register_values
    MINUS
    SELECT DISTINCT
        class_id,
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
        coh_dev_t.wwo_condition_set_q_master
;
