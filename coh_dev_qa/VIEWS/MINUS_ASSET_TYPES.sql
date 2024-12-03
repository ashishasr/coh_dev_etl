--------------------------------------------------------
--  DDL for View MINUS_ASSET_TYPES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_QA"."MINUS_ASSET_TYPES" ("CLASS_CODE_REVISED", "CLASS_DESCRIPTION_REVISED", "CATEGORY_CODE_REVISED", "CATEGORY_DESCRIPTION_REVISED", "ESTIMATED_USEFUL_LIFE_EUL", "INITIAL_REINVESTMENT_ACTION", "MAX_NO_OF_REHABS", "REHAB_REVITALIZATION", "REHAB_EUL", "MAX_POTENTIAL_LIFE") AS SELECT
    class_code_revised,
    class_description_revised,
    category_code_revised,
    category_description_revised,
    estimated_useful_life_eul,
    initial_reinvestment_action,
    max_no_of_rehabs,
    rehab_revitalization,
    rehab_eul,
    max_potential_life
FROM
    extract_asset_types
minus
SELECT
    class_code_revised,
    class_description_revised,
    category_code_revised,
    category_description_revised,
    estimated_useful_life_eul,
    initial_reinvestment_action,
    max_no_of_rehabs,
    rehab_revitalization,
    rehab_eul,
    max_potential_life
FROM
    template_asset_types
    
UNION ALL

SELECT
    class_code_revised,
    class_description_revised,
    category_code_revised,
    category_description_revised,
    estimated_useful_life_eul,
    initial_reinvestment_action,
    max_no_of_rehabs,
    rehab_revitalization,
    rehab_eul,
    max_potential_life
FROM
    template_asset_types
MINUS    
SELECT
    class_code_revised,
    class_description_revised,
    category_code_revised,
    category_description_revised,
    estimated_useful_life_eul,
    initial_reinvestment_action,
    max_no_of_rehabs,
    rehab_revitalization,
    rehab_eul,
    max_potential_life
FROM
    extract_asset_types
;
