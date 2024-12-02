--------------------------------------------------------
--  DDL for View DWO_WWO_UNQ_ASSET_CONDITION_Q_COMPARISION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "COH_DEV_L"."DWO_WWO_UNQ_ASSET_CONDITION_Q_COMPARISION" ("ORGANIZATION", "ASSET_TYPE", "SRC", "EAM_CLASS_ID", "EAM_CLASS_DESCRIPTION", "RAW_CLASS_ID", "RAW_CLASS_DESCRIPTION", "ASSET_COUNT", "CONDITION_Q1", "CONDITION_Q2", "CONDITION_Q3", "CONDITION_Q4", "CONDITION_Q5", "CONDITION_Q6", "CONDITION_Q7", "CONDITION_Q8", "CONDITION_Q9", "CONDITION_Q10") AS SELECT
        'WWO'           organization,
        'UNIQUE'        asset_type,
        src,
        eam_class_id,
        eam_class_description,
        raw_class_id,
        raw_class_description,
        COUNT(asset_id) asset_count,
        condition_q1,
        condition_q2,
        condition_q3,
        condition_q4,
        condition_q5,
        condition_q6,
        condition_q7,
        condition_q8,
        condition_q9,
        condition_q10
    FROM
        coh_dev_t.wwo_unq_asset_cleaned_no_calc
    GROUP BY
        src,
        eam_class_id,
        eam_class_description,
        raw_class_id,
        raw_class_description,
        condition_q1,
        condition_q2,
        condition_q3,
        condition_q4,
        condition_q5,
        condition_q6,
        condition_q7,
        condition_q8,
        condition_q9,
        condition_q10
    UNION ALL
    SELECT
        'DWO'                 organization,
        NULL                  asset_type,
        NULL                  source,
        dwo_class_id          eam_class_id,
        dwo_class_description eam_class_description,
        NULL                  raw_class_id,
        NULL                  raw_class_description,
        NULL                  asset_count,
        condition_q1,
        condition_q2,
        condition_q3,
        condition_q4,
        condition_q5,
        condition_q6,
        condition_q7,
        condition_q8,
        condition_q9,
        condition_q10
    FROM
        coh_dev_t.dwo_class_condition_q_master
    ORDER BY
        eam_class_description,
        organization
;
