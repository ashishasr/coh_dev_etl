--------------------------------------------------------
--  DDL for View CONDITION_Q_W
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_QA"."CONDITION_Q_W" ("DATA_UNIT", "CLASS_ID", "CLASS_DESCRIPTION", "RAW_CONDITION_Q_NO", "RAW_CONDITION_Q", "REF_CONDITION_Q_NO", "REF_CONDITION_Q") AS SELECT
        data_unit,
        class_id,
        class_description,
        raw_condition_q_no,
        raw_condition_q,

        ref_condition_q_no,
        ref_condition_q
    FROM
        test_cond_q_2
    WHERE
        instr(ref_condition_q, keyword_1) > 0
;
