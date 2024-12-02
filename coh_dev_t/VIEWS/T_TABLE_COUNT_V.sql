--------------------------------------------------------
--  DDL for View T_TABLE_COUNT_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_T"."T_TABLE_COUNT_V" ("TABLE_NAME", "NUM_ROWS") AS SELECT
        table_name,
        num_rows
    FROM
        all_tables
    WHERE
        owner = 'COH_DEV_T' order by table_name
;
