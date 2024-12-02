--------------------------------------------------------
--  DDL for View TEST_CONVERT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_T"."TEST_CONVERT" ("ASSET_ID", "CLASS_ID", "CLASS_DESCRIPTION", "FINAL_REF_CONDITION_Q_NO", "FINAL_REF_CONDITION_Q", "FINAL_CONDITION_A") AS SELECT
    asset_id,
    class_id,
    class_description,
    final_ref_condition_q_no,
    final_ref_condition_q,
    final_condition_a
FROM
    wwo_unq_asset_cleaned_no_calc_condition_q
WHERE
        class_description = 'AIR SCRUBBER'
    AND asset_id = '317003'
;
