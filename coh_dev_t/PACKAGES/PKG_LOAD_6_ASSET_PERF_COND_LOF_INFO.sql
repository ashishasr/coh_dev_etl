--------------------------------------------------------
--  DDL for Package PKG_LOAD_6_ASSET_PERF_COND_LOF_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "COH_DEV_T"."PKG_LOAD_6_ASSET_PERF_COND_LOF_INFO" AS

    FUNCTION get_lof_score (
        in_condition_score   NUMBER,
        in_performance_score NUMBER
    ) RETURN VARCHAR;

    FUNCTION get_lof_rating (
        in_lof_score VARCHAR
    ) RETURN VARCHAR;

    PROCEDURE start_data_refresh;

END pkg_load_6_asset_perf_cond_lof_info;

/
