--------------------------------------------------------
--  DDL for View E_DWO_CONDITION_SET_Q_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_E"."E_DWO_CONDITION_SET_Q_V" ("SET_NUM", "CONDITION_Q1", "CONDITION_Q2", "CONDITION_Q3", "CONDITION_Q4", "CONDITION_Q5", "CONDITION_Q6", "CONDITION_Q7", "CONDITION_Q8", "CONDITION_Q9", "CONDITION_Q10", "DT_INSERTED") AS SELECT
        trim(set_num),
        trim(condition_q1),
        trim(condition_q2),
        trim(condition_q3),
        trim(condition_q4),
        trim(condition_q5),
        trim(condition_q6),
        trim(condition_q7),
        trim(condition_q8),
        trim(condition_q9),
        trim(condition_q10),
        dt_inserted
    FROM
        e_dwo_condition_set_q
;
  GRANT READ ON "COH_DEV_E"."E_DWO_CONDITION_SET_Q_V" TO "COH_DEV_T" WITH GRANT OPTION;
