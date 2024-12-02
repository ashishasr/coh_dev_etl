--------------------------------------------------------
--  DDL for Package PKG_LOAD_8_CMN_ASSET_CPAL_INFO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "COH_DEV_T"."PKG_LOAD_8_CMN_ASSET_CPAL_INFO" AS
    FUNCTION get_cpal_1_action_timeframe_br1 (
        in_br1 VARCHAR
    ) RETURN VARCHAR;

    FUNCTION get_cpal_1_action_timeframe_br2 (
        in_br2 VARCHAR
    ) RETURN VARCHAR;

    FUNCTION get_cpal_1_action_timeframe_br3 (
        in_br3 VARCHAR
    ) RETURN VARCHAR;

    FUNCTION get_cpal_1_action_cost (
        in_class_id    VARCHAR,
        in_category_id VARCHAR
    ) RETURN NUMBER;

    FUNCTION get_cpal_2_action (
        in_no_of_rehab NUMBER
    ) RETURN VARCHAR;

    FUNCTION get_cpal_2_action_timeframe_br1 (
        in_no_of_rehabs               NUMBER,
        in_first_action_timeframe_br1 NUMBER,
        in_rehab_eul                  NUMBER,
        in_replacement_eul            NUMBER
    ) RETURN NUMBER;

    FUNCTION get_cpal_2_action_timeframe_br2 (
        in_no_of_rehabs               NUMBER,
        in_first_action_timeframe_br2 NUMBER,
        in_rehab_eul                  NUMBER,
        in_replacement_eul            NUMBER
    ) RETURN NUMBER;

    FUNCTION get_cpal_2_action_timeframe_br3 (
        in_no_of_rehabs               NUMBER,
        in_first_action_timeframe_br3 NUMBER,
        in_rehab_eul                  NUMBER,
        in_replacement_eul            NUMBER
    ) RETURN NUMBER;

    FUNCTION get_cpal_3_action (
        in_no_of_rehabs VARCHAR
    ) RETURN VARCHAR;

    FUNCTION get_cpal_3_action_timeframe_br1 (
        in_no_of_rehabs                NUMBER,
        in_second_action_timeframe_br1 NUMBER,
        in_rehab_eul                   NUMBER,
        in_replacement_eul             NUMBER
    ) RETURN NUMBER;

    FUNCTION get_cpal_3_action_timeframe_br2 (
        in_no_of_rehabs                NUMBER,
        in_second_action_timeframe_br2 NUMBER,
        in_rehab_eul                   NUMBER,
        in_replacement_eul             NUMBER
    ) RETURN NUMBER;

    FUNCTION get_cpal_3_action_timeframe_br3 (
        in_no_of_rehabs                NUMBER,
        in_second_action_timeframe_br3 NUMBER,
        in_rehab_eul                   NUMBER,
        in_replacement_eul             NUMBER
    ) RETURN VARCHAR;

    FUNCTION get_cpal_3_action_cost (
        in_class_id    VARCHAR,
        in_category_id VARCHAR,
        in_3rd_action  VARCHAR
    ) RETURN NUMBER;

    FUNCTION get_cpal_4_action (
        in_no_of_rehabs NUMBER
    ) RETURN VARCHAR;

    FUNCTION get_cpal_4_action_timeframe_br1 (
        in_no_of_rehabs                NUMBER,
        in_second_action_timeframe_br1 NUMBER,
        in_rehab_eul                   NUMBER,
        in_third_action_timeframe_br1  NUMBER,
        in_replacement_eul             NUMBER
    ) RETURN NUMBER;

    FUNCTION get_cpal_4_action_timeframe_br2 (
        in_no_of_rehabs                NUMBER,
        in_second_action_timeframe_br2 NUMBER,
        in_rehab_eul                   NUMBER,
        in_third_action_timeframe_br2  NUMBER,
        in_replacement_eul             NUMBER
    ) RETURN NUMBER;

    FUNCTION get_cpal_4_action_timeframe_br3 (
        in_no_of_rehabs                NUMBER,
        in_second_action_timeframe_br3 NUMBER,
        in_rehab_eul                   NUMBER,
        in_third_action_timeframe_br3  NUMBER,
        in_replacement_eul             NUMBER
    ) RETURN NUMBER;

    FUNCTION get_cpal_4_action_cost (
        in_class_id      VARCHAR,
        in_category_id   VARCHAR,
        in_fourth_action VARCHAR
    ) RETURN NUMBER;

    FUNCTION get_cpal_timeframe (
        in_br3 VARCHAR
    ) RETURN VARCHAR;

    PROCEDURE start_data_refresh;

END pkg_load_8_cmn_asset_cpal_info;

/
