--------------------------------------------------------
--  DDL for Package PKG_LOAD_2_ASSET_CONDITION_Q_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "COH_DEV_T"."PKG_LOAD_2_ASSET_CONDITION_Q_INFO" AS
    FUNCTION get_condition_score (
        in_condition_a1  NUMBER,
        in_condition_a2  NUMBER,
        in_condition_a3  NUMBER,
        in_condition_a4  NUMBER,
        in_condition_a5  NUMBER,
        in_condition_a6  NUMBER,
        in_condition_a7  NUMBER,
        in_condition_a8  NUMBER,
        in_condition_a9  NUMBER,
        in_condition_a10 NUMBER
    ) RETURN number;

    FUNCTION get_condition_rating (
        in_condition_score NUMBER
    ) RETURN VARCHAR;
    
    
    procedure start_data_refresh;

END pkg_load_2_asset_condition_q_info;

/
