--------------------------------------------------------
--  DDL for Function GET_AMC_AGE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_AMC_AGE" (in_min_system_commission_year varchar)
    return varchar
        is
            out_brr_age varchar(100);
        begin
            SELECT EXTRACT(YEAR FROM SYSDATE) - in_min_system_commission_year 
            into out_brr_age from dual;
            return out_brr_age;
        end;


/
