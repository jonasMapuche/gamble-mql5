CREATE VIEW LeftBuyFalse AS
    SELECT PATTERN,
           CASE WHEN QUANTITY IS NULL THEN 0 ELSE QUANTITY END AS QUANTITY
      FROM (
               SELECT COLOR.PATTERN,
                      BUY_TRUE.QUANTITY AS QUANTITY
                 FROM (
                          SELECT PATTERN,
                                 COUNT(1) AS QUANTITY
                            FROM ViewChoiseBuyFalse
                           GROUP BY PATTERN
                      )
                      BUY_TRUE
                      RIGHT OUTER JOIN
                      (
                          SELECT PATTERN
                            FROM ViewPattern
                      )
                      COLOR ON BUY_TRUE.PATTERN = COLOR.PATTERN
                ORDER BY COLOR.PATTERN
           )
           BUY_COLOR;
