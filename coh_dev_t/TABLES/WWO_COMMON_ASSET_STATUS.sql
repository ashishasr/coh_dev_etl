--------------------------------------------------------
--  DDL for Table WWO_COMMON_ASSET_STATUS
--------------------------------------------------------

  CREATE TABLE "COH_DEV_T"."WWO_COMMON_ASSET_STATUS" ("ASSET_ID" VARCHAR2(10), "ASSET_IN_EAM_FLAG" VARCHAR2(10) DEFAULT 'N', "RAW_TAB1_CLASS_ID" VARCHAR2(10), "RAW_TAB1_CLASS_DESCRIPTION" VARCHAR2(20), "RAW_TAB1_CLASS_ID_KNOWN_FLAG" CHAR(1) DEFAULT 'N', "RAW_TAB2_CLASS_ID" VARCHAR2(10), "RAW_TAB2_CLASS_DESCRIPTION" VARCHAR2(20), "RAW_TAB2_CLASS_ID_KNOWN_FLAG" CHAR(1) DEFAULT 'N', "EAM_CLASS_ID" VARCHAR2(10), "EAM_CLASS_DESCRIPTION" VARCHAR2(20), "EAM_CLASS_ID_KNOWN_FLAG" CHAR(1) DEFAULT 'N', "EAM_COMMISSION_DATE" DATE, "EAM_ASSET_STATUS" VARCHAR2(20), "ASSET_STATUS" CHAR(1), "STATUS_COMMENT" VARCHAR2(4000), "CHECKED_FLAG" CHAR(1) DEFAULT 'N', "DT_INSERTED" DATE DEFAULT sysdate) ;