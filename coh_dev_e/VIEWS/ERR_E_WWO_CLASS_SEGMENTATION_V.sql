--------------------------------------------------------
--  DDL for View ERR_E_WWO_CLASS_SEGMENTATION_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_E"."ERR_E_WWO_CLASS_SEGMENTATION_V" ("WWO_CLASS_ID", "WWO_CLASS_DESCRIPTION") AS SELECT
        wwo_class_id,
        wwo_class_description
    FROM
        e_wwo_class_segmentation_v
    MINUS
    SELECT
        class_id,
        class_description
    FROM
        e_class_description_v
;
