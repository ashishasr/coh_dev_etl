--------------------------------------------------------
--  Constraints for Table WWO_ASSET_TYPES_MASTER
--------------------------------------------------------

  ALTER TABLE "COH_DEV_T"."WWO_ASSET_TYPES_MASTER" MODIFY ("CLASS_ID" NOT NULL ENABLE);
  ALTER TABLE "COH_DEV_T"."WWO_ASSET_TYPES_MASTER" MODIFY ("CATEGORY_ID" NOT NULL ENABLE);
  ALTER TABLE "COH_DEV_T"."WWO_ASSET_TYPES_MASTER" ADD CONSTRAINT "WWO_ASSET_TYPES_MASTER_PK" PRIMARY KEY ("CLASS_ID", "CATEGORY_ID") USING INDEX  ENABLE;
