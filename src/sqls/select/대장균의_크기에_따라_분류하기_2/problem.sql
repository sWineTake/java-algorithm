-- 코드를 작성해주세요
WITH A AS (
    SELECT  ED.*,
            NTILE(4) OVER (ORDER BY ED.SIZE_OF_COLONY) AS le
      FROM ECOLI_DATA ED
)
SELECT A.ID,
       CASE
        WHEN le = 1 THEN 'LOW'
        WHEN le = 2 THEN 'MEDIUM'
        WHEN le = 3 THEN 'HIGH'
        WHEN le = 4 THEN 'CRITICAL'
       ELSE ''
       END AS COLONY_NAME
  FROM A
 ORDER BY A.ID
;
