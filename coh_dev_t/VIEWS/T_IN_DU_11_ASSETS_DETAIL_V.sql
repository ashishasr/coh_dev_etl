--------------------------------------------------------
--  DDL for View T_IN_DU_11_ASSETS_DETAIL_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_T"."T_IN_DU_11_ASSETS_DETAIL_V" ("ASSET_ID", "CLASS_ID", "CATEGORY", "DATA_UNIT", "WWO_CLASS_DESCRIPTION", "COMMON_CLASS_FLAG", "COMMON_NEW_COMMENTS") AS SELECT
        asset_id,
        class_id,
        replace(category,'*',NULL),
        data_unit,
        wwo_class_description,
        common_class_flag,
        common_new_comments
    FROM
             t_in_du_11_assets_v a
        INNER JOIN wwo_segmnt_unq_asset_class_master b ON a.class_id = b.wwo_class_id
;
  GRANT SELECT ON "COH_DEV_T"."T_IN_DU_11_ASSETS_DETAIL_V" TO "COH_DEV_L";
