--------------------------------------------------------
--  DDL for Function GET_AMC_ESTIMATED_USEFUL_LIFE_EUL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_AMC_ESTIMATED_USEFUL_LIFE_EUL" (in_class_id varchar, in_category_id varchar)
    return varchar
        is
            out_estimated_useful_life_eul varchar(100);
    begin
    SELECT
    ESTIMATED_USEFUL_LIFE
        into out_estimated_useful_life_eul from T_IN_WWO_ASSET_TYPES_V lk
            where lk.CLASS_ID = in_class_id and lk.CATEGORY_ID = in_category_id;
    return out_estimated_useful_life_eul;
    end;

/
