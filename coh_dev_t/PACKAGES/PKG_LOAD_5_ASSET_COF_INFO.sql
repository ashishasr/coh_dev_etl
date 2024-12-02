--------------------------------------------------------
--  DDL for Package PKG_LOAD_5_ASSET_COF_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "COH_DEV_T"."PKG_LOAD_5_ASSET_COF_INFO" AS
    FUNCTION get_cof_matrix_answers (
        in_matrix         VARCHAR,
        in_cof_matrix_key NUMBER
    ) RETURN VARCHAR;

    FUNCTION get_cof_score (
        in_replacement_cost  VARCHAR,
        in_om_impact         VARCHAR,
        in_level_of_service  VARCHAR,
        in_health_and_safety VARCHAR,
        in_permit_compliance VARCHAR,
        in_response_time     VARCHAR,
        in_service_priority  VARCHAR
    ) RETURN NUMBER;

    FUNCTION get_cof_rating (
        in_cof_score NUMBER
    ) RETURN VARCHAR;

    PROCEDURE start_data_refresh;

END pkg_load_5_asset_cof_info;

/
