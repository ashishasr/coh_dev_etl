--------------------------------------------------------
--  DDL for View E_WWO_CONDITION_Q_SOLUTION_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_E"."E_WWO_CONDITION_Q_SOLUTION_V" ("DATA_UNIT", "CLASS_ID", "CLASS_DESCRIPTION", "RAW_CONDITION_Q_NO", "RAW_CONDITION_Q", "REF_CONDITION_Q_NO", "REF_CONDITION_Q", "PROCEED") AS SELECT
        data_unit,
        class_id,
        class_description,
        raw_condition_q_no,
        raw_condition_q,
        ref_condition_q_no,
        ref_condition_q,
        upper(SUBSTR(proceed, 1, 1))
    FROM
        e_wwo_condition_q_solution
;
  GRANT READ ON "COH_DEV_E"."E_WWO_CONDITION_Q_SOLUTION_V" TO "COH_DEV_T";
