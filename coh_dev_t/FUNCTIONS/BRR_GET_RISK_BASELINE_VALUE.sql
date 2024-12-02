--------------------------------------------------------
--  DDL for Function BRR_GET_RISK_BASELINE_VALUE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."BRR_GET_RISK_BASELINE_VALUE" (in_lof_score number, in_cof_score number, in_redundancy_factor_revised number)
return varchar
is
out_risk_baseline_value varchar(100);
begin
SELECT 
    ROUND(in_lof_score, 2) * 
    ROUND(in_cof_score, 2) * 
    ROUND(in_redundancy_factor_revised, 2) AS Result
into out_risk_baseline_value from dual;
return out_risk_baseline_value;
end;

/
