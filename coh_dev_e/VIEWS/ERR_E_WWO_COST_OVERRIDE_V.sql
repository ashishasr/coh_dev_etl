--------------------------------------------------------
--  DDL for View ERR_E_WWO_COST_OVERRIDE_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_E"."ERR_E_WWO_COST_OVERRIDE_V" ("CLASS_ID", "CLASS_DESCRIPTION") AS SELECT
        class_id,
        class_description
    FROM
        e_wwo_cost_override_v
    MINUS
    SELECT
        class_id,
        class_description
    FROM
        e_class_description_v
;
