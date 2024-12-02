--------------------------------------------------------
--  DDL for View E_DWO_CONDITION_Q_CLASS_SET_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_E"."E_DWO_CONDITION_Q_CLASS_SET_V" ("SET_NUM", "CLASS_DESCRIPTION") AS SELECT
        trim(set_num),
        trim(class_description)
    FROM
        e_dwo_condition_q_class_set
;
  GRANT READ ON "COH_DEV_E"."E_DWO_CONDITION_Q_CLASS_SET_V" TO "COH_DEV_T" WITH GRANT OPTION;
