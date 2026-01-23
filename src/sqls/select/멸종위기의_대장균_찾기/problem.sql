SELECT  COUNT(1) AS COUNT,
        A.LEVEL AS GENERATION
  FROM (
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
            SELECT q.*,
                   (SELECT COUNT(1) FROM ECOLI_DATA WHERE PARENT_ID = q.ID ) AS PARENT_CNT
              FROM q
      ) AS A
 WHERE A.PARENT_CNT = 0
 GROUP BY A.LEVEL
