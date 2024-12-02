--------------------------------------------------------
--  DDL for View T_IN_DU_9_10_CLASS_CATEGORY_INFO_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_T"."T_IN_DU_9_10_CLASS_CATEGORY_INFO_V" ("EAM_CLASS_ID", "EAM_CLASS_DESCRIPTION", "CATEGORY", "CATEGORY_DESCRIPTION") AS SELECT
        eam_class_id,
        eam_class_description,
        category,
        category_description
    FROM
        coh_dev_e.e_du_9_10_class_category_info_v
;
