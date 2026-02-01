CREATE VIEW LeftSellTrue AS
    SELECT PATTERN,
           CASE WHEN QUANTITY IS NULL THEN 0 ELSE QUANTITY END AS QUANTITY
      FROM (
               SELECT COLOR.PATTERN,
                      SELL_TRUE.QUANTITY AS QUANTITY
                 FROM (
                          SELECT PATTERN,
                                 COUNT(1) AS QUANTITY
                            FROM ViewChoiseSellTrue
                           GROUP BY PATTERN
                      )
                      SELL_TRUE
                      RIGHT OUTER JOIN
                      (
                          SELECT PATTERN
                            FROM ViewPattern
                      )
                      COLOR ON SELL_TRUE.PATTERN = COLOR.PATTERN
                ORDER BY COLOR.PATTERN
           )
           BUY_COLOR;
