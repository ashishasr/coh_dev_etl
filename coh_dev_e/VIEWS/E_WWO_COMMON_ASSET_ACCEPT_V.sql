--------------------------------------------------------
--  DDL for View E_WWO_COMMON_ASSET_ACCEPT_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_E"."E_WWO_COMMON_ASSET_ACCEPT_V" ("SRC", "ASSET_ID", "REJECT_FLAG") AS select "SRC","ASSET_ID","REJECT_FLAG" from E_WWO_COMMON_ASSET_ACCEPT
;
  GRANT READ ON "COH_DEV_E"."E_WWO_COMMON_ASSET_ACCEPT_V" TO "COH_DEV_T";
