--------------------------------------------------------
--  DDL for Function GET_CIP_RECOMMENDED_REINVESTMENT_ACTION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CIP_RECOMMENDED_REINVESTMENT_ACTION" (in_class_id varchar, in_category_id varchar)
    return varchar
        is
            out_cip_recommended_reinvestment_action varchar(100);
    begin
    SELECT
    INITIAL_REINVESTMENT_ACTION 
        into out_cip_recommended_reinvestment_action from WWO_ASSET_TYPES_MASTER lk
            where lk.CLASS_ID = in_class_id and lk.CATEGORY_ID = in_category_id;
    return out_cip_recommended_reinvestment_action;
    end;

/
