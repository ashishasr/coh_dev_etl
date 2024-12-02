--------------------------------------------------------
--  DDL for Table E_WWO_CLASS_SEGMENTATION
--------------------------------------------------------

  CREATE TABLE "COH_DEV_E"."E_WWO_CLASS_SEGMENTATION" ("DATA_UNIT" NUMBER, "DWO_CLASS_DESCRIPTION" VARCHAR2(100), "WWO_CLASS_DESCRIPTION" VARCHAR2(100), "DWO_CLASS_ID" VARCHAR2(100), "WWO_CLASS_ID" VARCHAR2(100), "COMMON_NEW_COMMENTS" VARCHAR2(400), "COMMON_CLASS_FLAG" CHAR(1), "SEGMENTATION_COMMENTS" VARCHAR2(200), "DT_INSERTED" VARCHAR2(20) DEFAULT sysdate) ;
  GRANT READ ON "COH_DEV_E"."E_WWO_CLASS_SEGMENTATION" TO "COH_DEV_T" WITH GRANT OPTION;
