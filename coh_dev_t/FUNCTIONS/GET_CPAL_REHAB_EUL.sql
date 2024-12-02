--------------------------------------------------------
--  DDL for Function GET_CPAL_REHAB_EUL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CPAL_REHAB_EUL" (
in_class_id varchar, 
in_category_id varchar )
    return varchar
        is
            out_CPAL_REHAB_EUL varchar(100);
    begin
    SELECT
    REHAB_EUL 
        into out_CPAL_REHAB_EUL from WWO_ASSET_TYPES_MASTER lk
            where lk.CLASS_ID = in_class_id and lk.CATEGORY_ID = in_category_id;
    return out_CPAL_REHAB_EUL;
    end;

/
