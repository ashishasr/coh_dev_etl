--------------------------------------------------------
--  DDL for View E_DU_9_10_CLASS_CATEGORY_INFO_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_E"."E_DU_9_10_CLASS_CATEGORY_INFO_V" ("EAM_CLASS_ID", "EAM_CLASS_DESCRIPTION", "CATEGORY", "CATEGORY_DESCRIPTION") AS select "EAM_CLASS_ID","EAM_CLASS_DESCRIPTION","CATEGORY","CATEGORY_DESCRIPTION" from e_du_9_10_class_category_info
;
  GRANT SELECT ON "COH_DEV_E"."E_DU_9_10_CLASS_CATEGORY_INFO_V" TO "COH_DEV_T" WITH GRANT OPTION;
