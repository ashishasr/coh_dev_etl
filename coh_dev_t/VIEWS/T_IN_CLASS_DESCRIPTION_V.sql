--------------------------------------------------------
--  DDL for View T_IN_CLASS_DESCRIPTION_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_T"."T_IN_CLASS_DESCRIPTION_V" ("CLASS_ID", "CLASS_DESCRIPTION", "ORGANIZATION") AS SELECT
        class_id,
        class_description,
        organization
    FROM
        coh_dev_e.e_class_description_v
;
  GRANT READ ON "COH_DEV_T"."T_IN_CLASS_DESCRIPTION_V" TO "COH_DEV_L";
