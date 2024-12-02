--------------------------------------------------------
--  DDL for Function GET_CPAL_2_ACTION_COST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CPAL_2_ACTION_COST" (in_class_id varchar, in_category_id varchar, in_rehab_replacement varchar)
    return varchar
        is
            out_cpal_2_action_cost varchar(100);
    begin
    SELECT
    TOTAL_COST 
        into out_cpal_2_action_cost from WWO_COST_OVERRIDE_MASTER lk
            where lk.CLASS_ID = in_class_id and lk.CATEGORY_ID = in_category_id and lk.REHAB_REPLACEMENT = in_rehab_replacement;
    return out_cpal_2_action_cost;
    end;

/
