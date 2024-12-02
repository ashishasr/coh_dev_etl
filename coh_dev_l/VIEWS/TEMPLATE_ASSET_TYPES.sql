--------------------------------------------------------
--  DDL for View TEMPLATE_ASSET_TYPES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."TEMPLATE_ASSET_TYPES" ("CLASS_ID", "CLASS_DESCRIPTION", "CATEGORY_ID", "CATEGORY_DESCRIPTION", "ESTIMATED_USEFUL_LIFE", "INITIAL_REINVESTMENT_ACTION", "MAX_NO_OF_REHABS", "REHAB_REVITALIZATION", "REHAB_EUL", "MAX_POTENTIAL_LIFE") AS SELECT
    class_id,
    class_description,
    category_id,
    category_description,
    estimated_useful_life,
    null INITIAL_REINVESTMENT_ACTION,
    max_no_of_rehabs,
    rehab_revitalization,
    null REHAB_EUL,
    null MAX_POTENTIAL_LIFE
FROM
    extract_asset_types_values
;
