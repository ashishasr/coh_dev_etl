--------------------------------------------------------
--  DDL for Function GET_AMC_CONDITION_ADJUSTED_USEFULL_LIFE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_AMC_CONDITION_ADJUSTED_USEFULL_LIFE" 
    (in_condition_score number, in_percent_life_consumed number, in_estimated_useful_life number, in_age number)
    return varchar
        is
            out_condition_adjusted_usefull_life  varchar(100);
        begin
         SELECT 
    CEIL(
        CASE
            WHEN in_condition_score = 1 AND in_percent_life_consumed < 0.2 THEN in_estimated_useful_life
            WHEN in_condition_score = 1 AND in_percent_life_consumed >= 0.2 THEN in_age + (0.8 * in_estimated_useful_life)
            WHEN in_condition_score = 2 AND in_percent_life_consumed < 0.5 THEN in_estimated_useful_life
            WHEN in_condition_score = 2 AND in_percent_life_consumed >= 0.5 THEN in_age + (0.6 * in_estimated_useful_life)
            WHEN in_condition_score = 3 AND in_percent_life_consumed < 0.2 THEN 0.6 * in_estimated_useful_life
            WHEN in_condition_score = 3 AND in_percent_life_consumed >= 0.2 AND in_percent_life_consumed < 0.5 THEN 0.8 * in_estimated_useful_life
            WHEN in_condition_score = 3 AND in_percent_life_consumed >= 0.5 AND in_percent_life_consumed < 0.8 THEN in_estimated_useful_life
            WHEN in_condition_score = 3 AND in_percent_life_consumed >= 0.8 AND in_percent_life_consumed < 1 THEN in_age + (0.3 * in_estimated_useful_life)
            WHEN in_condition_score = 3 AND in_percent_life_consumed >= 1 AND in_percent_life_consumed < 2 THEN 1.2 * in_estimated_useful_life
            WHEN in_condition_score = 4 AND in_percent_life_consumed < 0.2 THEN 0.4 * in_estimated_useful_life
            WHEN in_condition_score = 4 AND in_percent_life_consumed >= 0.2 AND in_percent_life_consumed < 0.5 THEN 0.5 * in_estimated_useful_life
            WHEN in_condition_score = 4 AND in_percent_life_consumed >= 0.5 AND in_percent_life_consumed < 0.8 THEN 0.8 * in_estimated_useful_life
            WHEN in_condition_score = 4 AND in_percent_life_consumed >= 0.8 AND in_percent_life_consumed < 1 THEN in_estimated_useful_life
            WHEN in_condition_score = 4 AND in_percent_life_consumed >= 1 AND in_percent_life_consumed < 2 THEN in_estimated_useful_life
            WHEN in_condition_score = 5 THEN in_age
            ELSE in_estimated_useful_life
        END
    )
            into out_condition_adjusted_usefull_life from dual;
            return out_condition_adjusted_usefull_life;
        end;

/
