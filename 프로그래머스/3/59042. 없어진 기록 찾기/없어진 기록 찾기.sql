SELECT OUTS_ID as ANIMAL_ID, OUTS_NAME as NAME
FROM (
    SELECT 
        INS.ANIMAL_ID AS INS_ID,
        INS.NAME AS INS_NAME,
        OUTS.ANIMAL_ID AS OUTS_ID,
        OUTS.NAME AS OUTS_NAME
    FROM ANIMAL_INS INS
    LEFT JOIN ANIMAL_OUTS OUTS
    ON INS.ANIMAL_ID = OUTS.ANIMAL_ID

    UNION

    SELECT 
        INS.ANIMAL_ID AS INS_ID,
        INS.NAME AS INS_NAME,
        OUTS.ANIMAL_ID AS OUTS_ID,
        OUTS.NAME AS OUTS_NAME
    FROM ANIMAL_INS INS
    RIGHT JOIN ANIMAL_OUTS OUTS
    ON INS.ANIMAL_ID = OUTS.ANIMAL_ID
) AS FJ
WHERE INS_ID IS NULL
