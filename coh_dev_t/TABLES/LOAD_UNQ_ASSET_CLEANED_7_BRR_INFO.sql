--------------------------------------------------------
--  DDL for Table LOAD_UNQ_ASSET_CLEANED_7_BRR_INFO
--------------------------------------------------------

  CREATE TABLE "COH_DEV_T"."LOAD_UNQ_ASSET_CLEANED_7_BRR_INFO" ("ASSET_ID" VARCHAR2(10), "COF_SCORE" NUMBER, "LOF_SCORE" NUMBER, "CONDITION_SCORE" NUMBER, "PERFORMANCE_SCORE" NUMBER, "REDUNDANCY_FACTOR_REVISED" NUMBER, "PREDICTED_CIP_YEAR" VARCHAR2(200), "RISK_BASELINE_VALUE" NUMBER, "BR1" VARCHAR2(200), "BR2" VARCHAR2(200), "BR3" VARCHAR2(200), "DT_INSERTED" DATE DEFAULT sysdate) ;
  GRANT READ ON "COH_DEV_T"."LOAD_UNQ_ASSET_CLEANED_7_BRR_INFO" TO "COH_DEV_L";