--------------------------------------------------------
--  DDL for View T_IN_DWO_CONDITION_Q_CLASS_SET_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_T"."T_IN_DWO_CONDITION_Q_CLASS_SET_V" ("SET_NUM", "CLASS_DESCRIPTION") AS SELECT
        set_num,
        class_description
    FROM
        coh_dev_e.e_dwo_condition_q_class_set_v
;
  GRANT READ ON "COH_DEV_T"."T_IN_DWO_CONDITION_Q_CLASS_SET_V" TO "COH_DEV_L";
