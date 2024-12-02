--------------------------------------------------------
--  DDL for Function GET_CPAL_NO_OF_REHABS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CPAL_NO_OF_REHABS" (
in_class_id varchar, 
in_category_id varchar )
    return varchar
        is
            out_CPAL_NO_OF_REHABS varchar(100);
    begin
    SELECT
    MAX_NO_OF_REHABS 
        into out_CPAL_NO_OF_REHABS from WWO_ASSET_TYPES_MASTER lk
            where lk.CLASS_ID = in_class_id and lk.CATEGORY_ID = in_category_id;
    return out_CPAL_NO_OF_REHABS;
    end;

/
