--------------------------------------------------------
--  DDL for Package PKG_LOAD_P1A_MASTER_DATA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "COH_DEV_T"."PKG_LOAD_P1A_MASTER_DATA" AS
    FUNCTION get_initial_reinvestment_action (
        in_max_no_of_rehabs NUMBER
    ) RETURN VARCHAR;
------------------------------------------------------------------------------------------------
    FUNCTION get_rehab_eul (
        in_estimated_useful_life NUMBER,
        in_rehab_revitalization  NUMBER
    ) RETURN NUMBER;
----------------------------------------------------------------------------------
    FUNCTION get_max_potential_life (
        in_estimated_useful_life NUMBER,
        in_max_no_of_rehabs      NUMBER,
        in_rehab_eul             NUMBER
    ) RETURN NUMBER;

    PROCEDURE start_data_refresh;
    procedure proc_load_wwo_class_description_master;

END pkg_load_p1a_master_data;

/
