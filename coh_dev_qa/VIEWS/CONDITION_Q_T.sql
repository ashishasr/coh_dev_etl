--------------------------------------------------------
--  DDL for View CONDITION_Q_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_QA"."CONDITION_Q_T" ("DATA_UNIT", "CLASS_ID", "CLASS_DESCRIPTION", "RAW_CONDITION_Q_NO", "RAW_CONDITION_Q", "KEYWORD_1", "KEYWORD_2", "REF_CONDITION_Q_NO", "REF_CONDITION_Q") AS SELECT
    a.data_unit,
    a.class_id,
    a.class_description,
    a.raw_condition_q_no,
    a.raw_condition_q,
    keyword_1,
    keyword_2,
    ref_condition_q_no,
    ref_condition_q
FROM
         test_cond_q a
    INNER JOIN coh_dev_t.wwo_condition_set_q_master_transpose b ON a.class_id = b.class_id
;
