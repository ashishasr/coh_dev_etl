--------------------------------------------------------
--  DDL for View ERR_E_WWO_CONDITION_SET_Q_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_E"."ERR_E_WWO_CONDITION_SET_Q_V" ("CLASS_ID", "CLASS_DESCRIPTION") AS SELECT
        class_id,
        class_description
    FROM
        e_wwo_condition_set_q_v
    MINUS
    SELECT
        class_id,
        class_description
    FROM
        e_class_description_v
;
