--------------------------------------------------------
--  DDL for Function GET_BRR_BR3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_BRR_BR3" (in_predicted_cip_year varchar, in_br2 varchar)
return varchar
is
out_brr_br3 varchar(100);
begin
SELECT 
    CASE
        WHEN in_predicted_cip_year = '0 to 3' OR in_br2 = 'URGENT' THEN 'URGENT'
        WHEN in_predicted_cip_year = '3 to 5' OR in_br2 = 'PRIORITY' THEN 'PRIORITY'
        WHEN in_predicted_cip_year = '5 to 10' OR in_br2 = 'SHORT-TERM' THEN 'SHORT-TERM'
        WHEN in_predicted_cip_year = '10 to 20' OR in_br2 = 'MID-TERM' THEN 'MID-TERM'
        WHEN in_predicted_cip_year = '>20' OR in_br2 = 'LONG-TERM' THEN 'LONG-TERM'
        ELSE ''
    END
into out_brr_br3 from dual;
return out_brr_br3;
end;

/
