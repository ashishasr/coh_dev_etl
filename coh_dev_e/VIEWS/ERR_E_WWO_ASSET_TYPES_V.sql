--------------------------------------------------------
--  DDL for View ERR_E_WWO_ASSET_TYPES_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_E"."ERR_E_WWO_ASSET_TYPES_V" ("CLASS_ID", "CLASS_DESCRIPTION") AS SELECT
        class_id,
        class_description
    FROM
        e_wwo_asset_types_v
    MINUS
    SELECT
        class_id,
        class_description
    FROM
        e_class_description_v
;
