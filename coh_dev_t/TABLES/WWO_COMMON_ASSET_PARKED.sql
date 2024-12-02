--------------------------------------------------------
--  DDL for Table WWO_COMMON_ASSET_PARKED
--------------------------------------------------------

  CREATE TABLE "COH_DEV_T"."WWO_COMMON_ASSET_PARKED" ("ASSET_ID" VARCHAR2(10), "EAM_CLASS_ID" VARCHAR2(10), "EAM_CLASS_DESCRIPTION" VARCHAR2(20), "EAM_CLASS_ID_KNOWN_FLAG" CHAR(10), "EAM_COMMISSION_DATE" DATE, "RAW_TAB1_CLASS_ID" VARCHAR2(10), "RAW_TAB1_CLASS_DESCRIPTION" VARCHAR2(20), "RAW_TAB1_CLASS_ID_KNOWN_FLAG" CHAR(10), "RAW_TAB2_CLASS_ID" VARCHAR2(10), "RAW_TAB2_CLASS_DESCRIPTION" VARCHAR2(20), "RAW_TAB2_CLASS_ID_KNOWN_FLAG" CHAR(10), "PERFORMANCE_CAPACITY" VARCHAR2(100), "PERFORMANCE_RELIABILITY" VARCHAR2(100), "PERFORMANCE_OM" VARCHAR2(100), "PERFORMANCE_OBSOLESCENCE" VARCHAR2(100), "PERFORMANCE_REDUNDANCY" VARCHAR2(100), "PERFORMANCE_ERUL" VARCHAR2(20), "CONDITION_Q1" VARCHAR2(255), "CONDITION_A1" VARCHAR2(5), "CONDITION_Q2" VARCHAR2(255), "CONDITION_A2" VARCHAR2(5), "CONDITION_Q3" VARCHAR2(255), "CONDITION_A3" VARCHAR2(5), "CONDITION_Q4" VARCHAR2(255), "CONDITION_A4" VARCHAR2(5), "CONDITION_Q5" VARCHAR2(255), "CONDITION_A5" VARCHAR2(5), "CONDITION_Q6" VARCHAR2(255), "CONDITION_A6" VARCHAR2(5), "CONDITION_Q7" VARCHAR2(255), "CONDITION_A7" VARCHAR2(5), "CONDITION_Q8" VARCHAR2(255), "CONDITION_A8" VARCHAR2(5), "CONDITION_Q9" VARCHAR2(255), "CONDITION_A9" VARCHAR2(5), "CONDITION_Q10" VARCHAR2(255), "CONDITION_A10" VARCHAR2(5), "COF_REPLACEMENT_COST" VARCHAR2(10), "COF_OM_IMPACTS" VARCHAR2(10), "COF_LEVEL_OF_SERVICE" VARCHAR2(10), "COF_HEALTH_AND_SAFETY" VARCHAR2(10), "COF_PERMIT_COMPLIANCE" VARCHAR2(10), "COF_RESPONSE_TIME" VARCHAR2(10), "COF_SERVICE_PRIORITY" VARCHAR2(10), "SRC" CHAR(4), "STATUS_COMMENT" VARCHAR2(1000), "DT_INSERTED" DATE, "DATA_UNIT" FLOAT(126) DEFAULT NULL, "CLASS_TYPE" VARCHAR2(20) DEFAULT NULL, "CLEANED_FLAG" CHAR(1) DEFAULT 'N', "CATEGORY" VARCHAR2(20)) ;
  GRANT READ ON "COH_DEV_T"."WWO_COMMON_ASSET_PARKED" TO "COH_DEV_L";