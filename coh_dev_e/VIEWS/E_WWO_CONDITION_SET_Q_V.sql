--------------------------------------------------------
--  DDL for View E_WWO_CONDITION_SET_Q_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_E"."E_WWO_CONDITION_SET_Q_V" ("ORGANIZATION", "CLASS_ID", "CLASS_DESCRIPTION", "CONDITION_Q1", "CONDITION_Q2", "CONDITION_Q3", "CONDITION_Q4", "CONDITION_Q5", "CONDITION_Q6", "CONDITION_Q7", "CONDITION_Q8", "CONDITION_Q9", "CONDITION_Q10", "COMMENTS", "MATCHING_WITH_DWO", "DT_INSERTED") AS SELECT
        TRIM(organization),
        TRIM(class_id),
        TRIM(class_description),
        TRIM(condition_q1),
        TRIM(condition_q2),
        TRIM(condition_q3),
        TRIM(condition_q4),
        TRIM(condition_q5),
        TRIM(condition_q6),
        TRIM(condition_q7),
        TRIM(condition_q8),
        TRIM(condition_q9),
        TRIM(condition_q10),
        TRIM(comments),
        TRIM(upper(SUBSTR(matching_with_dwo, 1, 1))),
        dt_inserted
    FROM
        e_wwo_condition_set_q
;
  GRANT READ ON "COH_DEV_E"."E_WWO_CONDITION_SET_Q_V" TO "COH_DEV_T" WITH GRANT OPTION;
