--------------------------------------------------------
--  DDL for Table EXTRACT_ASSET_REGISTER
--------------------------------------------------------

  CREATE TABLE "COH_DEV_QA"."EXTRACT_ASSET_REGISTER" ("ASSET_ID" VARCHAR2(10), "CLASS_ID" VARCHAR2(10), "CLASS_DESCRIPTION" VARCHAR2(100), "CATEGORY_ID" VARCHAR2(10), "CATEGORY_DESCRIPTION" VARCHAR2(100), "COMMISSION_DATE" DATE, "MIN_SYSTEM_COMMISSION_YEAR" VARCHAR2(10), "CONDITION_Q1" VARCHAR2(4000), "CONDITION_A1" NUMBER(1,0), "CONDITION_Q2" VARCHAR2(4000), "CONDITION_A2" NUMBER(1,0), "CONDITION_Q3" VARCHAR2(4000), "CONDITION_A3" NUMBER(1,0), "CONDITION_Q4" VARCHAR2(4000), "CONDITION_A4" NUMBER(1,0), "CONDITION_Q5" VARCHAR2(4000), "CONDITION_A5" NUMBER(1,0), "CONDITION_Q6" VARCHAR2(4000), "CONDITION_A6" NUMBER(1,0), "CONDITION_Q7" VARCHAR2(4000), "CONDITION_A7" NUMBER(1,0), "CONDITION_Q8" VARCHAR2(4000), "CONDITION_A8" NUMBER(1,0), "CONDITION_Q9" VARCHAR2(4000), "CONDITION_A9" NUMBER(1,0), "CONDITION_Q10" VARCHAR2(4000), "CONDITION_A10" NUMBER(1,0), "CONDITION_SCORE" NUMBER(1,0), "CONDITION_RATING" VARCHAR2(20), "PERFORMANCE_CAPACITY" VARCHAR2(500), "PERFORMANCE_RELIABILITY" VARCHAR2(500), "PERFORMANCE_OM" VARCHAR2(500), "PERFORMANCE_OBSOLESCENCE" VARCHAR2(500), "PERFORMANCE_REDUNDANCY" VARCHAR2(500), "PERFORMANCE_SCORE" NUMBER, "PERFORMANCE_RATING" VARCHAR2(20), "LOF_SCORE" NUMBER, "LOF_RATING" VARCHAR2(20), "REDUNDANCY_FACTOR_REVISED" NUMBER, "ESTIMATED_USEFUL_LIFE" NUMBER, "AGE" NUMBER, "LIFE_REMAINING" NUMBER, "PERCENT_LIFE_CONSUMED_NUMBER" NUMBER, "CONDITION_ADJUSTED_USEFUL_LIFE" NUMBER, "CONDITION_ADJUSTED_LIFE_REMAINING" NUMBER, "CONDITION_ADJUSTED_PERCENT_LIFE_CONSUMED_NUMBER" NUMBER, "PREDICTED_REPLACEMENT_YEAR" NUMBER, "PREDICTED_CIP_YEAR" VARCHAR2(20), "COF_REPLACEMENT_COST" VARCHAR2(100), "COF_OM_IMPACTS" VARCHAR2(100), "COF_LEVEL_OF_SERVICE" VARCHAR2(100), "COF_HEALTH_AND_SAFETY" VARCHAR2(100), "COF_PERMIT_COMPLIANCE" VARCHAR2(100), "COF_RESPONSE_TIME" VARCHAR2(100), "COF_SERVICE_PRIORITY" VARCHAR2(100), "COF_SCORE" NUMBER, "COF_RATING" VARCHAR2(100), "RISK_BASELINE_VALUE" NUMBER(5,2), "BR1" VARCHAR2(200), "BR2" VARCHAR2(200), "BR3" VARCHAR2(200), "CIP_RECOMMENDED_REINVESTMENT_ACTION" VARCHAR2(100), "COST_OVERRIDE" NUMBER, "REHAB_EUL" NUMBER, "NO_OF_REHAB" VARCHAR2(100), "REPLACEMENT_EUL" NUMBER, "FIRST_ACTION" VARCHAR2(10), "FIRST_ACTION_TIMEFRAME_BR_1" NUMBER, "FIRST_ACTION_TIMEFRAME_BR_2" NUMBER, "FIRST_ACTION_TIMEFRAME_BR_3" NUMBER, "FIRST_ACTION_COST" NUMBER, "SECOND_ACTION" VARCHAR2(10), "SECOND_ACTION_TIMEFRAME_BR_1" NUMBER, "SECOND_ACTION_TIMEFRAME_BR_2" NUMBER, "SECOND_ACTION_TIMEFRAME_BR_3" NUMBER, "SECOND_ACTION_COST" NUMBER, "THIRD_ACTION" VARCHAR2(10), "THIRD_ACTION_TIMEFRAME_BR_1" NUMBER, "THIRD_ACTION_TIMEFRAME_BR_2" NUMBER, "THIRD_ACTION_TIMEFRAME_BR_3" NUMBER, "THIRD_ACTION_COST" NUMBER, "FOURTH_ACTION" VARCHAR2(10), "FOURTH_ACTION_TIMEFRAME_BR_1" NUMBER, "FOURTH_ACTION_TIMEFRAME_BR_2" NUMBER, "FOURTH_ACTION_TIMEFRAME_BR_3" NUMBER, "FOURTH_ACTION_COST" NUMBER, "TIMEFRAME" VARCHAR2(100)) ;