--------------------------------------------------------
--  DDL for Function GET_ASSET_TYPE_MAX_POTENTIAL_LIFE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_ASSET_TYPE_MAX_POTENTIAL_LIFE" (
in_estimated_useful_life_eul number, 
in_max_no_of_rehabs number, 
in_rehab_eul number
)
    return varchar
        is
            out_max_potential_life varchar(100);
        begin
            SELECT 
        in_estimated_useful_life_eul + in_max_no_of_rehabs * in_rehab_eul
            into out_max_potential_life from dual;
            return out_max_potential_life;
        end;

/
