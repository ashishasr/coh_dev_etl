--------------------------------------------------------
--  DDL for Package PKG_LOAD_7_ASSET_BRR_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "COH_DEV_T"."PKG_LOAD_7_ASSET_BRR_INFO" AS
    FUNCTION get_brr_risk_baseline_value (
        in_lof_score                 NUMBER,
        in_cof_score                 NUMBER,
        in_redundancy_factor_revised NUMBER
    ) RETURN VARCHAR;

    FUNCTION get_brr_br1 (
        in_risk_baseline_value NUMBER
    ) RETURN VARCHAR;

    FUNCTION get_brr_br2 (
        in_condition_score VARCHAR,
        in_br1             VARCHAR
    ) RETURN VARCHAR;

    FUNCTION get_brr_br3 (
        in_predicted_cip_year VARCHAR,
        in_br2                VARCHAR
    ) RETURN VARCHAR;

    PROCEDURE start_data_refresh;

END pkg_load_7_asset_brr_info;

/
