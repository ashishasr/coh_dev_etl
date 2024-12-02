--------------------------------------------------------
--  DDL for Function GET_MIN_SYSTEM_COMMISION_YR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_MIN_SYSTEM_COMMISION_YR" (in_commission_date varchar)
return varchar
is
out_min_system_commision_yr varchar(100);
begin
Select NVL(TO_CHAR(EXTRACT(YEAR FROM TO_DATE(in_commission_date, 'MM/DD/YYYY'))), '1980')
into out_min_system_commision_yr from dual;
return out_min_system_commision_yr;
end;

/
