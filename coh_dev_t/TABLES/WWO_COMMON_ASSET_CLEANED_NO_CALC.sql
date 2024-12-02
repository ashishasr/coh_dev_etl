--------------------------------------------------------
--  DDL for Table WWO_COMMON_ASSET_CLEANED_NO_CALC
--------------------------------------------------------

  CREATE TABLE "COH_DEV_T"."WWO_COMMON_ASSET_CLEANED_NO_CALC" ("ASSET_ID" VARCHAR2(10), "EAM_CLASS_ID" VARCHAR2(10), "EAM_CLASS_DESCRIPTION" VARCHAR2(20), "EAM_CLASS_ID_KNOWN_FLAG" CHAR(10), "EAM_COMMISSION_DATE" DATE, "RAW_TAB1_CLASS_ID" VARCHAR2(10), "RAW_TAB1_CLASS_DESCRIPTION" VARCHAR2(20), "RAW_TAB1_CLASS_ID_KNOWN_FLAG" CHAR(1), "RAW_TAB2_CLASS_ID" VARCHAR2(10), "RAW_TAB2_CLASS_DESCRIPTION" VARCHAR2(20), "RAW_TAB2_CLASS_ID_KNOWN_FLAG" CHAR(1), "PERFORMANCE_CAPACITY" VARCHAR2(100), "PERFORMANCE_RELIABILITY" VARCHAR2(100), "PERFORMANCE_OM" VARCHAR2(100), "PERFORMANCE_OBSOLESCENCE" VARCHAR2(100), "PERFORMANCE_REDUNDANCY" VARCHAR2(100), "PERFORMANCE_ERUL" VARCHAR2(100), "CONDITION_Q1" VARCHAR2(255), "CONDITION_A1" VARCHAR2(5), "CONDITION_Q2" VARCHAR2(255), "CONDITION_A2" VARCHAR2(5), "CONDITION_Q3" VARCHAR2(255), "CONDITION_A3" VARCHAR2(5), "CONDITION_Q4" VARCHAR2(255), "CONDITION_A4" VARCHAR2(5), "CONDITION_Q5" VARCHAR2(255), "CONDITION_A5" VARCHAR2(5), "CONDITION_Q6" VARCHAR2(255), "CONDITION_A6" VARCHAR2(5), "CONDITION_Q7" VARCHAR2(255), "CONDITION_A7" VARCHAR2(5), "CONDITION_Q8" VARCHAR2(255), "CONDITION_A8" VARCHAR2(5), "CONDITION_Q9" VARCHAR2(255), "CONDITION_A9" VARCHAR2(5), "CONDITION_Q10" VARCHAR2(255), "CONDITION_A10" VARCHAR2(5), "COF_REPLACEMENT_COST" VARCHAR2(100), "COF_OM_IMPACTS" VARCHAR2(100), "COF_LEVEL_OF_SERVICE" VARCHAR2(100), "COF_HEALTH_AND_SAFETY" VARCHAR2(100), "COF_PERMIT_COMPLIANCE" VARCHAR2(100), "COF_RESPONSE_TIME" VARCHAR2(100), "COF_SERVICE_PRIORITY" VARCHAR2(100), "SRC" CHAR(4), "DT_INSERTED" DATE DEFAULT sysdate, "ALL_ZERO_FLAG" CHAR(1), "REJECT_FLAG" CHAR(1), "REJECT_ACCEPT_COMMENTS" VARCHAR2(4000), "SAME_CONDITION_Q_FLAG" CHAR(1), "DU" FLOAT(126), "CATEGORY" VARCHAR2(10)) ;
  GRANT READ ON "COH_DEV_T"."WWO_COMMON_ASSET_CLEANED_NO_CALC" TO "COH_DEV_L";