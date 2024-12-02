--------------------------------------------------------
--  DDL for Table E_DU_11_ASSETS
--------------------------------------------------------

  CREATE TABLE "COH_DEV_E"."E_DU_11_ASSETS" ("ASSET_ID" VARCHAR2(10), "DESCRIPTION" VARCHAR2(255), "CLASS_ID" VARCHAR2(10), "CATEGORY" VARCHAR2(20)) ;
  GRANT ALTER ON "COH_DEV_E"."E_DU_11_ASSETS" TO "COH_DEV_T" WITH GRANT OPTION;
  GRANT DELETE ON "COH_DEV_E"."E_DU_11_ASSETS" TO "COH_DEV_T" WITH GRANT OPTION;
  GRANT INDEX ON "COH_DEV_E"."E_DU_11_ASSETS" TO "COH_DEV_T" WITH GRANT OPTION;
  GRANT INSERT ON "COH_DEV_E"."E_DU_11_ASSETS" TO "COH_DEV_T" WITH GRANT OPTION;
  GRANT SELECT ON "COH_DEV_E"."E_DU_11_ASSETS" TO "COH_DEV_T" WITH GRANT OPTION;
  GRANT UPDATE ON "COH_DEV_E"."E_DU_11_ASSETS" TO "COH_DEV_T" WITH GRANT OPTION;
  GRANT REFERENCES ON "COH_DEV_E"."E_DU_11_ASSETS" TO "COH_DEV_T" WITH GRANT OPTION;
  GRANT READ ON "COH_DEV_E"."E_DU_11_ASSETS" TO "COH_DEV_T" WITH GRANT OPTION;
  GRANT ON COMMIT REFRESH ON "COH_DEV_E"."E_DU_11_ASSETS" TO "COH_DEV_T" WITH GRANT OPTION;
  GRANT QUERY REWRITE ON "COH_DEV_E"."E_DU_11_ASSETS" TO "COH_DEV_T" WITH GRANT OPTION;
  GRANT DEBUG ON "COH_DEV_E"."E_DU_11_ASSETS" TO "COH_DEV_T" WITH GRANT OPTION;
  GRANT FLASHBACK ON "COH_DEV_E"."E_DU_11_ASSETS" TO "COH_DEV_T" WITH GRANT OPTION;