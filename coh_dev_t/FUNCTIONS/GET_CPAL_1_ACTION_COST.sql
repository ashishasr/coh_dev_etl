--------------------------------------------------------
--  DDL for Function GET_CPAL_1_ACTION_COST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_CPAL_1_ACTION_COST" (
    in_cost_override VARCHAR
) RETURN VARCHAR IS
    out_cpal_1_action_cost VARCHAR(100);
BEGIN
    SELECT
        in_cost_override
    INTO out_cpal_1_action_cost
    FROM
        dual;

    RETURN out_cpal_1_action_cost;
END;

/
