SELECT PATTERN,
       SUM(QUANTITY) AS sum
  FROM (
           SELECT MAIN.pattern,
                  MAIN.DAY,
                  SUM(MAIN.quantity) AS quantity
             FROM (
                      SELECT substr(date_time, 1, 4) || substr(date_time, 6, 2) || substr(date_time, 9, 2) AS day,
                             substr(date_time, 12, 2) || substr(date_time, 15, 2) AS time,
                             pattern,
                             1 AS quantity
                        FROM Hit
                  )
                  AS MAIN
            WHERE MAIN.pattern <> 'DOJI' AND 
                  MAIN.pattern <> 'MARUBOZU' AND 
                  MAIN.pattern <> 'SPINNINGTOP' AND
                  MAIN.DAY = '20231214'
            GROUP BY MAIN.DAY,
                     MAIN.pattern
            ORDER BY MAIN.DAY
       )
       CUBE
 GROUP BY PATTERN