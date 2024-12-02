--------------------------------------------------------
--  DDL for View T_IN_WWO_MATRIX_ANSWERS_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_T"."T_IN_WWO_MATRIX_ANSWERS_V" ("MATRIX", "MATRIX_ANSWERS", "DT_INSERTED") AS SELECT
"MATRIX","MATRIX_ANSWERS","DT_INSERTED"
    FROM
        coh_dev_e.e_wwo_matrix_answers_v
;
  GRANT READ ON "COH_DEV_T"."T_IN_WWO_MATRIX_ANSWERS_V" TO "COH_DEV_L";
