--------------------------------------------------------
--  DDL for Package PKG_LOAD_4_CMN_ASSET_AMC_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "COH_DEV_T"."PKG_LOAD_4_CMN_ASSET_AMC_INFO" AS
    FUNCTION get_amc_age (
        in_min_system_commission_year NUMBER
    ) RETURN NUMBER;

    FUNCTION get_amc_life_remaining (
        in_estimated_useful_life NUMBER,
        in_age                   NUMBER
    ) RETURN NUMBER;

    FUNCTION get_amc_percent_life_consumed_number (
        in_estimated_useful_life NUMBER,
        in_life_remaining        NUMBER
    ) RETURN NUMBER;

    FUNCTION get_amc_condition_adjusted_useful_life (
        in_condition_score       NUMBER,
        in_percent_life_consumed_number NUMBER,
        in_estimated_useful_life NUMBER,
        in_age                   NUMBER
    ) RETURN NUMBER;

    FUNCTION get_amc_condition_adjusted_life_remaining (
        in_condition_adjusted_useful_life NUMBER,
        in_age                            NUMBER
    ) RETURN NUMBER;

    FUNCTION get_amc_condition_adjusted_percent_life_consumed_number (
        in_estimated_useful_life             NUMBER,
        in_condition_adjusted_life_remaining NUMBER
    ) RETURN NUMBER;

    FUNCTION get_amc_predicted_replacement_year (
        in_condition_adjusted_life_remaining NUMBER
    ) RETURN NUMBER;

    FUNCTION get_amc_predicted_cip_year (
        in_condition_adjusted_life_remaining NUMBER
    ) RETURN varchar;


    PROCEDURE start_data_refresh;

END pkg_load_4_cmn_asset_amc_info;

/
