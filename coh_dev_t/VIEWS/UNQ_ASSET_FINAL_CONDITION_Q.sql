--------------------------------------------------------
--  DDL for View UNQ_ASSET_FINAL_CONDITION_Q
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_T"."UNQ_ASSET_FINAL_CONDITION_Q" ("ASSET_ID", "CLASS_ID", "CLASS_DESCRIPTION", "CONDITION_Q1", "CONDITION_A1", "CONDITION_Q2", "CONDITION_A2", "CONDITION_Q3", "CONDITION_A3", "CONDITION_Q4", "CONDITION_A4", "CONDITION_Q5", "CONDITION_A5", "CONDITION_Q6", "CONDITION_A6", "CONDITION_Q7", "CONDITION_A7", "CONDITION_Q8", "CONDITION_A8", "CONDITION_Q9", "CONDITION_A9", "CONDITION_Q10", "CONDITION_A10") AS WITH a AS (
    SELECT
        *
    FROM
        (
            SELECT
                asset_id,
                class_id,
                class_description,
                final_ref_condition_q_no,
                final_condition_a
            FROM
                wwo_unq_asset_cleaned_no_calc_condition_q
        ) PIVOT (
            MAX(final_condition_a)
            FOR final_ref_condition_q_no
            IN ( 'CONDITION_Q1' AS condition_q1, 'CONDITION_Q2' AS condition_q2, 'CONDITION_Q3' AS condition_q3, 'CONDITION_Q3' AS condition_q4
            , 'CONDITION_Q3' AS condition_q5, 'CONDITION_Q3' AS condition_q6, 'CONDITION_Q3' AS condition_q7, 'CONDITION_Q3' AS condition_q8
            , 'CONDITION_Q3' AS condition_q9, 'CONDITION_Q3' AS condition_q10 )
        )
), b AS (
    SELECT
        *
    FROM
        (
            SELECT
                asset_id,
                class_id,
                final_ref_condition_q_no,
                final_ref_condition_q
            FROM
                wwo_unq_asset_cleaned_no_calc_condition_q
        ) PIVOT (
            MAX(final_ref_condition_q)
            FOR final_ref_condition_q_no
            IN ( 'CONDITION_Q1' AS condition_q1, 'CONDITION_Q2' AS condition_q2, 'CONDITION_Q3' AS condition_q3, 'CONDITION_Q3' AS condition_q4
            , 'CONDITION_Q3' AS condition_q5, 'CONDITION_Q3' AS condition_q6, 'CONDITION_Q3' AS condition_q7, 'CONDITION_Q3' AS condition_q8
            , 'CONDITION_Q3' AS condition_q9, 'CONDITION_Q3' AS condition_q10 )
        )
)
SELECT
    a.asset_id,
    a.class_id,
    a.class_description,
    b.condition_q1,
    a.condition_q1 condition_a1,
        b.condition_q2,
    a.condition_q2 condition_a2,
        b.condition_q3,
    a.condition_q3 condition_a3,
        b.condition_q4,
    a.condition_q4 condition_a4,
        b.condition_q5,
    a.condition_q5 condition_a5,
        b.condition_q6,
    a.condition_q6 condition_a6,
        b.condition_q7,
    a.condition_q7 condition_a7,
        b.condition_q8,
    a.condition_q8 condition_a8,
        b.condition_q9,
    a.condition_q9 condition_a9,
        b.condition_q10,
    a.condition_q10 condition_a10
FROM
    a,
    b
WHERE
    a.asset_id = b.asset_id order by class_description, asset_id
;
