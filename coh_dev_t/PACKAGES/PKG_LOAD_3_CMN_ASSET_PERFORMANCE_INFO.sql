--------------------------------------------------------
--  DDL for Package PKG_LOAD_3_CMN_ASSET_PERFORMANCE_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "COH_DEV_T"."PKG_LOAD_3_CMN_ASSET_PERFORMANCE_INFO" AS
    FUNCTION get_performace_matrix_answers (
        in_matrix                 VARCHAR,
        in_performance_matrix_key NUMBER
    ) RETURN VARCHAR;

    FUNCTION get_performance_score (
        in_capacity     VARCHAR,
        in_reliability  VARCHAR,
        in_o_m          VARCHAR,
        in_obsolescence VARCHAR,
        in_redundancy   VARCHAR
    ) RETURN NUMBER;

    FUNCTION get_performance_rating (
        in_performance_score NUMBER
    ) RETURN VARCHAR;

    FUNCTION get_redundancy_factor_revised (
        in_redundancy VARCHAR
    ) RETURN NUMBER;

    PROCEDURE start_data_refresh;

END pkg_load_3_cmn_asset_performance_info;

/
