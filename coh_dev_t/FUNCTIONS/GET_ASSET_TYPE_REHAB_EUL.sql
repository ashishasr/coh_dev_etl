--------------------------------------------------------
--  DDL for Function GET_ASSET_TYPE_REHAB_EUL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_ASSET_TYPE_REHAB_EUL" (in_estimated_useful_life_eul number, in_rehab_revitalization number)
    return varchar
        is
            out_rehab_eul varchar(100);
        begin
            SELECT 
        in_estimated_useful_life_eul * in_rehab_revitalization
            into out_rehab_eul from dual;
            return out_rehab_eul;
        end;

/
