SELECT MES_1.PATTERN,
       MES_1.QUANTITY AS QTD_1_MES,
       MES_2.QUANTITY AS QTD_2_MES,
       MES_3.QUANTITY AS QTD_3_MES,
       MES_4.QUANTITY AS QTD_4_MES,
       MES_5.QUANTITY AS QTD_5_MES,
       MES_6.QUANTITY AS QTD_6_MES,
       MES_7.QUANTITY AS QTD_7_MES,
       MES_8.QUANTITY AS QTD_8_MES,
       MES_9.QUANTITY AS QTD_9_MES,
       MES_10.QUANTITY AS QTD_10_MES,
       MES_11.QUANTITY AS QTD_11_MES,
       MES_12.QUANTITY AS QTD_12_MES
  FROM (
           SELECT ViewPattern.PATTERN,
                  CASE WHEN HIT_MONTH.QUANTITY IS NULL THEN 0 ELSE HIT_MONTH.QUANTITY END AS QUANTITY
             FROM (
                      SELECT PATTERN,
                             COUNT(1) AS QUANTITY
                        FROM (
                                 SELECT CAST (strftime('%m', DATE_EVENT) AS DECIMAL) AS MONTH,
                                        PATTERN
                                   FROM (
                                            SELECT DATE(substr(date, 1, 4) || '-' || substr(date, 6, 2) || '-' || substr(date, 9, 2) ) AS DATE_EVENT,
                                                   PATTERN,
                                                   DATE
                                              FROM (
                                                       SELECT DISTINCT DATE,
                                                                       PATTERN
                                                         FROM HIT
                                                        WHERE PATTERN <> 'DOJI' AND 
                                                              PATTERN <> 'MARUBOZU' AND 
                                                              PATTERN <> 'SPINNINGTOP'
                                                   )
                                                   HIT
                                        )
                                        HIT_ALL
                             )
                             HIT_COUNT
                       WHERE MONTH = 1
                       GROUP BY PATTERN
                  )
                  HIT_MONTH
                  RIGHT OUTER JOIN
                  ViewPattern ON HIT_MONTH.PATTERN = ViewPattern.PATTERN
            ORDER BY ViewPattern.PATTERN
       )
       MES_1
       INNER JOIN
       (
           SELECT ViewPattern.PATTERN,
                  CASE WHEN HIT_MONTH.QUANTITY IS NULL THEN 0 ELSE HIT_MONTH.QUANTITY END AS QUANTITY
             FROM (
                      SELECT PATTERN,
                             COUNT(1) AS QUANTITY
                        FROM (
                                 SELECT CAST (strftime('%m', DATE_EVENT) AS DECIMAL) AS MONTH,
                                        PATTERN
                                   FROM (
                                            SELECT DATE(substr(date, 1, 4) || '-' || substr(date, 6, 2) || '-' || substr(date, 9, 2) ) AS DATE_EVENT,
                                                   PATTERN,
                                                   DATE
                                              FROM (
                                                       SELECT DISTINCT DATE,
                                                                       PATTERN
                                                         FROM HIT
                                                        WHERE PATTERN <> 'DOJI' AND 
                                                              PATTERN <> 'MARUBOZU' AND 
                                                              PATTERN <> 'SPINNINGTOP'
                                                   )
                                                   HIT
                                        )
                                        HIT_ALL
                             )
                             HIT_COUNT
                       WHERE MONTH = 2
                       GROUP BY PATTERN
                  )
                  HIT_MONTH
                  RIGHT OUTER JOIN
                  ViewPattern ON HIT_MONTH.PATTERN = ViewPattern.PATTERN
            ORDER BY ViewPattern.PATTERN
       )
       MES_2 ON MES_1.PATTERN = MES_2.PATTERN
       INNER JOIN
       (
           SELECT ViewPattern.PATTERN,
                  CASE WHEN HIT_MONTH.QUANTITY IS NULL THEN 0 ELSE HIT_MONTH.QUANTITY END AS QUANTITY
             FROM (
                      SELECT PATTERN,
                             COUNT(1) AS QUANTITY
                        FROM (
                                 SELECT CAST (strftime('%m', DATE_EVENT) AS DECIMAL) AS MONTH,
                                        PATTERN
                                   FROM (
                                            SELECT DATE(substr(date, 1, 4) || '-' || substr(date, 6, 2) || '-' || substr(date, 9, 2) ) AS DATE_EVENT,
                                                   PATTERN,
                                                   DATE
                                              FROM (
                                                       SELECT DISTINCT DATE,
                                                                       PATTERN
                                                         FROM HIT
                                                        WHERE PATTERN <> 'DOJI' AND 
                                                              PATTERN <> 'MARUBOZU' AND 
                                                              PATTERN <> 'SPINNINGTOP'
                                                   )
                                                   HIT
                                        )
                                        HIT_ALL
                             )
                             HIT_COUNT
                       WHERE MONTH = 3
                       GROUP BY PATTERN
                  )
                  HIT_MONTH
                  RIGHT OUTER JOIN
                  ViewPattern ON HIT_MONTH.PATTERN = ViewPattern.PATTERN
            ORDER BY ViewPattern.PATTERN
       )
       MES_3 ON MES_1.PATTERN = MES_3.PATTERN
       INNER JOIN
       (
           SELECT ViewPattern.PATTERN,
                  CASE WHEN HIT_MONTH.QUANTITY IS NULL THEN 0 ELSE HIT_MONTH.QUANTITY END AS QUANTITY
             FROM (
                      SELECT PATTERN,
                             COUNT(1) AS QUANTITY
                        FROM (
                                 SELECT CAST (strftime('%m', DATE_EVENT) AS DECIMAL) AS MONTH,
                                        PATTERN
                                   FROM (
                                            SELECT DATE(substr(date, 1, 4) || '-' || substr(date, 6, 2) || '-' || substr(date, 9, 2) ) AS DATE_EVENT,
                                                   PATTERN,
                                                   DATE
                                              FROM (
                                                       SELECT DISTINCT DATE,
                                                                       PATTERN
                                                         FROM HIT
                                                        WHERE PATTERN <> 'DOJI' AND 
                                                              PATTERN <> 'MARUBOZU' AND 
                                                              PATTERN <> 'SPINNINGTOP'
                                                   )
                                                   HIT
                                        )
                                        HIT_ALL
                             )
                             HIT_COUNT
                       WHERE MONTH = 4
                       GROUP BY PATTERN
                  )
                  HIT_MONTH
                  RIGHT OUTER JOIN
                  ViewPattern ON HIT_MONTH.PATTERN = ViewPattern.PATTERN
            ORDER BY ViewPattern.PATTERN
       )
       MES_4 ON MES_1.PATTERN = MES_4.PATTERN
       INNER JOIN
       (
           SELECT ViewPattern.PATTERN,
                  CASE WHEN HIT_MONTH.QUANTITY IS NULL THEN 0 ELSE HIT_MONTH.QUANTITY END AS QUANTITY
             FROM (
                      SELECT PATTERN,
                             COUNT(1) AS QUANTITY
                        FROM (
                                 SELECT CAST (strftime('%m', DATE_EVENT) AS DECIMAL) AS MONTH,
                                        PATTERN
                                   FROM (
                                            SELECT DATE(substr(date, 1, 4) || '-' || substr(date, 6, 2) || '-' || substr(date, 9, 2) ) AS DATE_EVENT,
                                                   PATTERN,
                                                   DATE
                                              FROM (
                                                       SELECT DISTINCT DATE,
                                                                       PATTERN
                                                         FROM HIT
                                                        WHERE PATTERN <> 'DOJI' AND 
                                                              PATTERN <> 'MARUBOZU' AND 
                                                              PATTERN <> 'SPINNINGTOP'
                                                   )
                                                   HIT
                                        )
                                        HIT_ALL
                             )
                             HIT_COUNT
                       WHERE MONTH = 5
                       GROUP BY PATTERN
                  )
                  HIT_MONTH
                  RIGHT OUTER JOIN
                  ViewPattern ON HIT_MONTH.PATTERN = ViewPattern.PATTERN
            ORDER BY ViewPattern.PATTERN
       )
       MES_5 ON MES_1.PATTERN = MES_5.PATTERN
       INNER JOIN
       (
           SELECT ViewPattern.PATTERN,
                  CASE WHEN HIT_MONTH.QUANTITY IS NULL THEN 0 ELSE HIT_MONTH.QUANTITY END AS QUANTITY
             FROM (
                      SELECT PATTERN,
                             COUNT(1) AS QUANTITY
                        FROM (
                                 SELECT CAST (strftime('%m', DATE_EVENT) AS DECIMAL) AS MONTH,
                                        PATTERN
                                   FROM (
                                            SELECT DATE(substr(date, 1, 4) || '-' || substr(date, 6, 2) || '-' || substr(date, 9, 2) ) AS DATE_EVENT,
                                                   PATTERN,
                                                   DATE
                                              FROM (
                                                       SELECT DISTINCT DATE,
                                                                       PATTERN
                                                         FROM HIT
                                                        WHERE PATTERN <> 'DOJI' AND 
                                                              PATTERN <> 'MARUBOZU' AND 
                                                              PATTERN <> 'SPINNINGTOP'
                                                   )
                                                   HIT
                                        )
                                        HIT_ALL
                             )
                             HIT_COUNT
                       WHERE MONTH = 6
                       GROUP BY PATTERN
                  )
                  HIT_MONTH
                  RIGHT OUTER JOIN
                  ViewPattern ON HIT_MONTH.PATTERN = ViewPattern.PATTERN
            ORDER BY ViewPattern.PATTERN
       )
       MES_6 ON MES_1.PATTERN = MES_6.PATTERN
       INNER JOIN
       (
           SELECT ViewPattern.PATTERN,
                  CASE WHEN HIT_MONTH.QUANTITY IS NULL THEN 0 ELSE HIT_MONTH.QUANTITY END AS QUANTITY
             FROM (
                      SELECT PATTERN,
                             COUNT(1) AS QUANTITY
                        FROM (
                                 SELECT CAST (strftime('%m', DATE_EVENT) AS DECIMAL) AS MONTH,
                                        PATTERN
                                   FROM (
                                            SELECT DATE(substr(date, 1, 4) || '-' || substr(date, 6, 2) || '-' || substr(date, 9, 2) ) AS DATE_EVENT,
                                                   PATTERN,
                                                   DATE
                                              FROM (
                                                       SELECT DISTINCT DATE,
                                                                       PATTERN
                                                         FROM HIT
                                                        WHERE PATTERN <> 'DOJI' AND 
                                                              PATTERN <> 'MARUBOZU' AND 
                                                              PATTERN <> 'SPINNINGTOP'
                                                   )
                                                   HIT
                                        )
                                        HIT_ALL
                             )
                             HIT_COUNT
                       WHERE MONTH = 7
                       GROUP BY PATTERN
                  )
                  HIT_MONTH
                  RIGHT OUTER JOIN
                  ViewPattern ON HIT_MONTH.PATTERN = ViewPattern.PATTERN
            ORDER BY ViewPattern.PATTERN
       )
       MES_7 ON MES_1.PATTERN = MES_7.PATTERN
       INNER JOIN
       (
           SELECT ViewPattern.PATTERN,
                  CASE WHEN HIT_MONTH.QUANTITY IS NULL THEN 0 ELSE HIT_MONTH.QUANTITY END AS QUANTITY
             FROM (
                      SELECT PATTERN,
                             COUNT(1) AS QUANTITY
                        FROM (
                                 SELECT CAST (strftime('%m', DATE_EVENT) AS DECIMAL) AS MONTH,
                                        PATTERN
                                   FROM (
                                            SELECT DATE(substr(date, 1, 4) || '-' || substr(date, 6, 2) || '-' || substr(date, 9, 2) ) AS DATE_EVENT,
                                                   PATTERN,
                                                   DATE
                                              FROM (
                                                       SELECT DISTINCT DATE,
                                                                       PATTERN
                                                         FROM HIT
                                                        WHERE PATTERN <> 'DOJI' AND 
                                                              PATTERN <> 'MARUBOZU' AND 
                                                              PATTERN <> 'SPINNINGTOP'
                                                   )
                                                   HIT
                                        )
                                        HIT_ALL
                             )
                             HIT_COUNT
                       WHERE MONTH = 8
                       GROUP BY PATTERN
                  )
                  HIT_MONTH
                  RIGHT OUTER JOIN
                  ViewPattern ON HIT_MONTH.PATTERN = ViewPattern.PATTERN
            ORDER BY ViewPattern.PATTERN
       )
       MES_8 ON MES_1.PATTERN = MES_8.PATTERN
       INNER JOIN
       (
           SELECT ViewPattern.PATTERN,
                  CASE WHEN HIT_MONTH.QUANTITY IS NULL THEN 0 ELSE HIT_MONTH.QUANTITY END AS QUANTITY
             FROM (
                      SELECT PATTERN,
                             COUNT(1) AS QUANTITY
                        FROM (
                                 SELECT CAST (strftime('%m', DATE_EVENT) AS DECIMAL) AS MONTH,
                                        PATTERN
                                   FROM (
                                            SELECT DATE(substr(date, 1, 4) || '-' || substr(date, 6, 2) || '-' || substr(date, 9, 2) ) AS DATE_EVENT,
                                                   PATTERN,
                                                   DATE
                                              FROM (
                                                       SELECT DISTINCT DATE,
                                                                       PATTERN
                                                         FROM HIT
                                                        WHERE PATTERN <> 'DOJI' AND 
                                                              PATTERN <> 'MARUBOZU' AND 
                                                              PATTERN <> 'SPINNINGTOP'
                                                   )
                                                   HIT
                                        )
                                        HIT_ALL
                             )
                             HIT_COUNT
                       WHERE MONTH = 9
                       GROUP BY PATTERN
                  )
                  HIT_MONTH
                  RIGHT OUTER JOIN
                  ViewPattern ON HIT_MONTH.PATTERN = ViewPattern.PATTERN
            ORDER BY ViewPattern.PATTERN
       )
       MES_9 ON MES_1.PATTERN = MES_9.PATTERN
       INNER JOIN
       (
           SELECT ViewPattern.PATTERN,
                  CASE WHEN HIT_MONTH.QUANTITY IS NULL THEN 0 ELSE HIT_MONTH.QUANTITY END AS QUANTITY
             FROM (
                      SELECT PATTERN,
                             COUNT(1) AS QUANTITY
                        FROM (
                                 SELECT CAST (strftime('%m', DATE_EVENT) AS DECIMAL) AS MONTH,
                                        PATTERN
                                   FROM (
                                            SELECT DATE(substr(date, 1, 4) || '-' || substr(date, 6, 2) || '-' || substr(date, 9, 2) ) AS DATE_EVENT,
                                                   PATTERN,
                                                   DATE
                                              FROM (
                                                       SELECT DISTINCT DATE,
                                                                       PATTERN
                                                         FROM HIT
                                                        WHERE PATTERN <> 'DOJI' AND 
                                                              PATTERN <> 'MARUBOZU' AND 
                                                              PATTERN <> 'SPINNINGTOP'
                                                   )
                                                   HIT
                                        )
                                        HIT_ALL
                             )
                             HIT_COUNT
                       WHERE MONTH = 10
                       GROUP BY PATTERN
                  )
                  HIT_MONTH
                  RIGHT OUTER JOIN
                  ViewPattern ON HIT_MONTH.PATTERN = ViewPattern.PATTERN
            ORDER BY ViewPattern.PATTERN
       )
       MES_10 ON MES_1.PATTERN = MES_10.PATTERN
       INNER JOIN
       (
           SELECT ViewPattern.PATTERN,
                  CASE WHEN HIT_MONTH.QUANTITY IS NULL THEN 0 ELSE HIT_MONTH.QUANTITY END AS QUANTITY
             FROM (
                      SELECT PATTERN,
                             COUNT(1) AS QUANTITY
                        FROM (
                                 SELECT CAST (strftime('%m', DATE_EVENT) AS DECIMAL) AS MONTH,
                                        PATTERN
                                   FROM (
                                            SELECT DATE(substr(date, 1, 4) || '-' || substr(date, 6, 2) || '-' || substr(date, 9, 2) ) AS DATE_EVENT,
                                                   PATTERN,
                                                   DATE
                                              FROM (
                                                       SELECT DISTINCT DATE,
                                                                       PATTERN
                                                         FROM HIT
                                                        WHERE PATTERN <> 'DOJI' AND 
                                                              PATTERN <> 'MARUBOZU' AND 
                                                              PATTERN <> 'SPINNINGTOP'
                                                   )
                                                   HIT
                                        )
                                        HIT_ALL
                             )
                             HIT_COUNT
                       WHERE MONTH = 11
                       GROUP BY PATTERN
                  )
                  HIT_MONTH
                  RIGHT OUTER JOIN
                  ViewPattern ON HIT_MONTH.PATTERN = ViewPattern.PATTERN
            ORDER BY ViewPattern.PATTERN
       )
       MES_11 ON MES_1.PATTERN = MES_11.PATTERN
       INNER JOIN
       (
           SELECT ViewPattern.PATTERN,
                  CASE WHEN HIT_MONTH.QUANTITY IS NULL THEN 0 ELSE HIT_MONTH.QUANTITY END AS QUANTITY
             FROM (
                      SELECT PATTERN,
                             COUNT(1) AS QUANTITY
                        FROM (
                                 SELECT CAST (strftime('%m', DATE_EVENT) AS DECIMAL) AS MONTH,
                                        PATTERN
                                   FROM (
                                            SELECT DATE(substr(date, 1, 4) || '-' || substr(date, 6, 2) || '-' || substr(date, 9, 2) ) AS DATE_EVENT,
                                                   PATTERN,
                                                   DATE
                                              FROM (
                                                       SELECT DISTINCT DATE,
                                                                       PATTERN
                                                         FROM HIT
                                                        WHERE PATTERN <> 'DOJI' AND 
                                                              PATTERN <> 'MARUBOZU' AND 
                                                              PATTERN <> 'SPINNINGTOP'
                                                   )
                                                   HIT
                                        )
                                        HIT_ALL
                             )
                             HIT_COUNT
                       WHERE MONTH = 12
                       GROUP BY PATTERN
                  )
                  HIT_MONTH
                  RIGHT OUTER JOIN
                  ViewPattern ON HIT_MONTH.PATTERN = ViewPattern.PATTERN
            ORDER BY ViewPattern.PATTERN
       )
       MES_12 ON MES_1.PATTERN = MES_12.PATTERN