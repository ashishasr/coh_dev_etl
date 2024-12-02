--------------------------------------------------------
--  DDL for View T_IN_WWO_CLASS_SEGMENTATION_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_T"."T_IN_WWO_CLASS_SEGMENTATION_V" ("DATA_UNIT", "DWO_CLASS_DESCRIPTION", "WWO_CLASS_DESCRIPTION", "DWO_CLASS_ID", "WWO_CLASS_ID", "COMMON_NEW_COMMENTS", "COMMON_CLASS_FLAG", "SEGMENTATION_COMMENTS") AS SELECT
        data_unit,
        dwo_class_description,
        wwo_class_description,
        dwo_class_id,
        wwo_class_id,
        common_new_comments,
        common_class_flag,
        segmentation_comments
    FROM
        coh_dev_e.e_wwo_class_segmentation_v
    ORDER BY
        data_unit
;
  GRANT READ ON "COH_DEV_T"."T_IN_WWO_CLASS_SEGMENTATION_V" TO "COH_DEV_L";
