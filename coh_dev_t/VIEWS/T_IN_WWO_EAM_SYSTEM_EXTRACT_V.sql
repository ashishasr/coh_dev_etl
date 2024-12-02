--------------------------------------------------------
--  DDL for View T_IN_WWO_EAM_SYSTEM_EXTRACT_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_T"."T_IN_WWO_EAM_SYSTEM_EXTRACT_V" ("ASSET_ID", "CLASS_ID", "STATUS", "COMMISSION_DATE", "CATEGORY") AS SELECT
        asset,
        class,
        status,
        commission_date,
        category
    FROM
        coh_dev_e.e_wwo_eam_system_extract_v
;
  GRANT READ ON "COH_DEV_T"."T_IN_WWO_EAM_SYSTEM_EXTRACT_V" TO "COH_DEV_L";
