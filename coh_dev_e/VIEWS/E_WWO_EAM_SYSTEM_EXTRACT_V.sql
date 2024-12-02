--------------------------------------------------------
--  DDL for View E_WWO_EAM_SYSTEM_EXTRACT_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_E"."E_WWO_EAM_SYSTEM_EXTRACT_V" ("ASSET", "DESCRIPTION", "ORGANIZATION", "STATUS", "DEPARTMENT", "CLASS", "CATEGORY", "COMMISSION_DATE", "OUT_OF_SERVICE", "ASSIGNED_TO", "PRODUCTION", "DT_INSERTED") AS SELECT
        trim(asset),
        trim(description),
        trim(organization),
        trim(status),
        trim(department),
        trim(class),
        trim(category),
        trim(commission_date),
        trim(out_of_service),
        trim(assigned_to),
        trim(production),
        dt_inserted
    FROM
        e_wwo_eam_system_extract
;
  GRANT DELETE ON "COH_DEV_E"."E_WWO_EAM_SYSTEM_EXTRACT_V" TO "COH_DEV_T";
  GRANT INSERT ON "COH_DEV_E"."E_WWO_EAM_SYSTEM_EXTRACT_V" TO "COH_DEV_T";
  GRANT SELECT ON "COH_DEV_E"."E_WWO_EAM_SYSTEM_EXTRACT_V" TO "COH_DEV_T";
  GRANT UPDATE ON "COH_DEV_E"."E_WWO_EAM_SYSTEM_EXTRACT_V" TO "COH_DEV_T";
  GRANT REFERENCES ON "COH_DEV_E"."E_WWO_EAM_SYSTEM_EXTRACT_V" TO "COH_DEV_T";
  GRANT READ ON "COH_DEV_E"."E_WWO_EAM_SYSTEM_EXTRACT_V" TO "COH_DEV_T" WITH GRANT OPTION;
  GRANT ON COMMIT REFRESH ON "COH_DEV_E"."E_WWO_EAM_SYSTEM_EXTRACT_V" TO "COH_DEV_T";
  GRANT QUERY REWRITE ON "COH_DEV_E"."E_WWO_EAM_SYSTEM_EXTRACT_V" TO "COH_DEV_T";
  GRANT DEBUG ON "COH_DEV_E"."E_WWO_EAM_SYSTEM_EXTRACT_V" TO "COH_DEV_T";
  GRANT FLASHBACK ON "COH_DEV_E"."E_WWO_EAM_SYSTEM_EXTRACT_V" TO "COH_DEV_T";
  GRANT MERGE VIEW ON "COH_DEV_E"."E_WWO_EAM_SYSTEM_EXTRACT_V" TO "COH_DEV_T";
