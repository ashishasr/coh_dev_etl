--------------------------------------------------------
--  DDL for Procedure PROC_CLEAN_ENVIRONMENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "COH_DEV_QA"."PROC_CLEAN_ENVIRONMENT" 
is
BEGIN
    EXECUTE IMMEDIATE 'truncate table EXTRACT_ASSET_REGISTER';
    EXECUTE IMMEDIATE 'truncate table EXTRACT_ASSET_TYPES';
    EXECUTE IMMEDIATE 'truncate table EXTRACT_COST_OVERRIDE';
    EXECUTE IMMEDIATE 'truncate table TEMPLATE_ASSET_REGISTER';
    EXECUTE IMMEDIATE 'truncate table TEMPLATE_ASSET_TYPES';
    EXECUTE IMMEDIATE 'truncate table TEMPLATE_COST_OVERRIDE';
END;

/
