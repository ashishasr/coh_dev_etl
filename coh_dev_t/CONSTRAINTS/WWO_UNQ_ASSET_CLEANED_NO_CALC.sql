--------------------------------------------------------
--  Constraints for Table WWO_UNQ_ASSET_CLEANED_NO_CALC
--------------------------------------------------------

  ALTER TABLE "COH_DEV_T"."WWO_UNQ_ASSET_CLEANED_NO_CALC" MODIFY ("ASSET_ID" NOT NULL ENABLE);
  ALTER TABLE "COH_DEV_T"."WWO_UNQ_ASSET_CLEANED_NO_CALC" ADD CONSTRAINT "LOAD_UNQ_ASSET_CLEANED_NO_CALC_PK" PRIMARY KEY ("ASSET_ID") USING INDEX  ENABLE;
