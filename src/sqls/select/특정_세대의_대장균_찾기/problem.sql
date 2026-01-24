-- 코드를 작성해주세요
WITH RECURSIVE q AS (
    SELECT ID,
           PARENT_ID,
           1 AS LEVEL
      FROM ECOLI_DATA
     WHERE PARENT_ID IS NULL

    UNION ALL

    SELECT ED.ID,
           ED.PARENT_ID,
           q.LEVEL + 1 AS LEVEL
      FROM ECOLI_DATA ED
     INNER JOIN q ON ED.PARENT_ID = q.ID
)

SELECT q.ID
  FROM q
 WHERE q.LEVEL = 3
  ;
