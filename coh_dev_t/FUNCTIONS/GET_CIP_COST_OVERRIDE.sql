--------------------------------------------------------
--  DDL for Function GET_CIP_COST_OVERRIDE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CIP_COST_OVERRIDE" (
in_class_id varchar, 
in_category_id varchar, 
in_recommended_reinvestment_action varchar)
    return varchar
        is
            out_CIP_COST_OVERRIDE varchar(100);
    begin
    SELECT
    TOTAL_COST 
        into out_CIP_COST_OVERRIDE from WWO_COST_OVERRIDE_MASTER lk
            where lk.CLASS_ID = in_class_id and lk.CATEGORY_ID = in_category_id
            and lk.rehab_replacement = in_recommended_reinvestment_action;
    return out_CIP_COST_OVERRIDE;
    end;

/
