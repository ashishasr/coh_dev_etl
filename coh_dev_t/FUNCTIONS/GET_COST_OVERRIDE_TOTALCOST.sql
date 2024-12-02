--------------------------------------------------------
--  DDL for Function GET_COST_OVERRIDE_TOTALCOST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_COST_OVERRIDE_TOTALCOST" (
in_subtotal number,
in_contingency number
)
    return varchar
        is
            out_totalcost varchar(100);
        begin
            SELECT ROUND(SUM(in_subtotal + in_contingency), -2)
            into out_totalcost from dual;
            return out_totalcost;
        end;

/
