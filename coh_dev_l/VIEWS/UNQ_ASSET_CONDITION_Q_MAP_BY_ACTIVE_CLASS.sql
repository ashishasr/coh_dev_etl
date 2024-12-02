--------------------------------------------------------
--  DDL for View UNQ_ASSET_CONDITION_Q_MAP_BY_ACTIVE_CLASS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."UNQ_ASSET_CONDITION_Q_MAP_BY_ACTIVE_CLASS" ("DATA_UNIT", "CLASS_ID", "CLASS_DESCRIPTION", "RAW_CONDITION_Q_ID", "RAW_CONDITION_Q_NO", "RAW_CONDITION_Q", "FINAL_REF_CONDITION_Q_ID", "FINAL_REF_CONDITION_Q_NO", "FINAL_REF_CONDITION_Q", "REF_CONDITION_Q_ID", "REF_CONDITION_Q_NO", "REF_CONDITION_Q", "MATCH_COMMENTS", "RCD_CHECKED") AS SELECT
        data_unit,
        class_id,
        class_description,
        raw_condition_q_id,
        raw_condition_q_no,
        raw_condition_q,
        final_ref_condition_q_id,
        final_ref_condition_q_no,
        final_ref_condition_q,
        ref_condition_q_id,
        ref_condition_q_no,
        ref_condition_q,
        match_comments,
        rcd_checked
    FROM
        coh_dev_t.unq_asset_condition_q_map
    WHERE
        class_id IN (
            SELECT
                class_id
            FROM
                active_class_condition_q
            WHERE
                active_flag = 'Y'
        )
;
