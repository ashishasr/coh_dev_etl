--------------------------------------------------------
--  DDL for View UNQ_ASSET_CLEANED_NO_CALC_CONDITION_Q_BY_ACT_CLASS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."UNQ_ASSET_CLEANED_NO_CALC_CONDITION_Q_BY_ACT_CLASS" ("ASSET_ID", "DATA_UNIT", "CLASS_ID", "CLASS_DESCRIPTION", "RAW_CONDITION_Q_NO", "RAW_CONDITION_Q", "RAW_CONDITION_A_NO", "RAW_CONDITION_A", "RAW_CONDITION_Q_ID", "FINAL_REF_CONDITION_Q_ID", "FINAL_REF_CONDITION_Q_NO", "FINAL_REF_CONDITION_Q", "MATCH_COMMENTS") AS SELECT
        a.asset_id,
        b.data_unit,
        a.class_id,
        a.class_description,
        raw_condition_q_no,
        raw_condition_q,
        raw_condition_a_no,
        raw_condition_a,
        raw_condition_q_id,
        final_ref_condition_q_id,
        final_ref_condition_q_no,
        final_ref_condition_q,
        match_comments
    FROM
             coh_dev_t.wwo_unq_asset_cleaned_no_calc_condition_q a
        INNER JOIN segmentation_by_class b ON a.class_id = b.wwo_class_id
        INNER JOIN ACTIVE_CLASS_CONDITION_Q     c ON a.class_id = c.class_id
                                          AND active_flag = 'Y'
    ORDER BY
        data_unit,
        a.class_description,
        a.asset_id,
        a.raw_condition_q_no
;
