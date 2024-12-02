--------------------------------------------------------
--  DDL for View E_TABLE_COUNT_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_E"."E_TABLE_COUNT_V" ("TABLE_NAME", "NUM_ROWS") AS SELECT
        table_name,
        num_rows
    FROM
        all_tables
    WHERE
        owner = 'COH_DEV_E'
    ORDER BY
        table_name
;
