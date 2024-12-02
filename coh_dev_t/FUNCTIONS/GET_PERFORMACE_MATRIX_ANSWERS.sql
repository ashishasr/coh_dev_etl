--------------------------------------------------------
--  DDL for Function GET_PERFORMACE_MATRIX_ANSWERS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "COH_DEV_T"."GET_PERFORMACE_MATRIX_ANSWERS" (
    in_matrix                 VARCHAR,
    in_performance_matrix_key NUMBER
) RETURN VARCHAR IS
    out_performance_matrix_answer VARCHAR2(200);
BEGIN
    SELECT
        matrix_answers
    INTO out_performance_matrix_answer
    FROM
        t_in_wwo_matrix_answers_v
    WHERE
            matrix = in_matrix
        AND matrix_key = in_performance_matrix_key;

    RETURN out_performance_matrix_answer;
END;

/
