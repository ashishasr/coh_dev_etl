--------------------------------------------------------
--  DDL for View TEST_102_REC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_T"."TEST_102_REC" ("ASSET_ID", "CLASS_ID", "CLASS_DESCRIPTION", "RAW_CONDITION_Q_NO", "RAW_CONDITION_Q", "RAW_CONDITION_A_NO", "RAW_CONDITION_A", "SRC", "RAW_CONDITION_Q_ID", "FINAL_REF_CONDITION_Q_ID", "FINAL_REF_CONDITION_Q_NO", "FINAL_REF_CONDITION_Q", "MATCH_COMMENTS", "FINAL_CONDITION_A", "RAW_FINAL_MATCH") AS SELECT
    asset_id,
    class_id,
    class_description,
    raw_condition_q_no,
    raw_condition_q,
    raw_condition_a_no,
    raw_condition_a,
    src,
    raw_condition_q_id,
    final_ref_condition_q_id,
    final_ref_condition_q_no,
    final_ref_condition_q,
    match_comments,
    final_condition_a,
    case when raw_condition_q = final_ref_condition_q then 'Y' else 'N' end raw_final_match
FROM
    wwo_common_asset_cleaned_no_calc_condition_q
WHERE
    asset_id IN (
        SELECT DISTINCT
            asset_id
        FROM
            wwo_common_asset_cleaned_no_calc
        WHERE
            reject_accept_comments IS NULL
    )
ORDER BY
    1
;
