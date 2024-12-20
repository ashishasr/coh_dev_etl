--------------------------------------------------------
--  DDL for Table UNQ_ASSET_CONDITION_Q_MAP
--------------------------------------------------------

  CREATE TABLE "COH_DEV_T"."UNQ_ASSET_CONDITION_Q_MAP" ("DATA_UNIT" NUMBER, "CLASS_ID" VARCHAR2(20), "CLASS_DESCRIPTION" VARCHAR2(100), "RAW_CONDITION_Q_ID" NUMBER, "RAW_CONDITION_Q_NO" VARCHAR2(13), "RAW_CONDITION_Q" VARCHAR2(255), "REF_CONDITION_Q_ID" NUMBER, "REF_CONDITION_Q_NO" VARCHAR2(13), "REF_CONDITION_Q" VARCHAR2(255), "MATCH_COMMENTS" VARCHAR2(200), "RCD_CHECKED" CHAR(1), "FINAL_REF_CONDITION_Q_ID" NUMBER, "FINAL_REF_CONDITION_Q_NO" VARCHAR2(200), "FINAL_REF_CONDITION_Q" VARCHAR2(255)) ;
  GRANT READ ON "COH_DEV_T"."UNQ_ASSET_CONDITION_Q_MAP" TO "COH_DEV_L";
