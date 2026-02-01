SELECT BEHIND.DATEROOT AS DATE,
       BUY.PATTERN
  FROM (
           SELECT MAIN.ANO || '.' || MAIN.MES || '.' || MAIN.DIA || ' ' || MAIN.HORA || ':' || MAIN.MINUTO2 || MAIN.MINUTO3 || MAIN.MINUTO4 || MAIN.MINUTO5 AS DATEROOT
             FROM (
                      SELECT substr(A0.date, 1, 4) AS ano,
                             substr(A0.date, 6, 2) AS mes,
                             substr(A0.date, 9, 2) AS dia,
                             substr(A0.date, 12, 2) AS hora,
                             substr(A0.date, 15, 2) AS minuto,
                             CASE WHEN CAST (substr(A0.date, 15, 2) AS DECIMAL) < 15 THEN '00' ELSE '' END AS minuto2,
                             CASE WHEN (CAST (substr(A0.date, 15, 2) AS DECIMAL) >= 15 AND 
                                        CAST (substr(A0.date, 15, 2) AS DECIMAL) < 30) THEN '15' ELSE '' END AS minuto3,
                             CASE WHEN (CAST (substr(A0.date, 15, 2) AS DECIMAL) >= 30 AND 
                                        CAST (substr(A0.date, 15, 2) AS DECIMAL) < 45) THEN '30' ELSE '' END AS minuto4,
                             CASE WHEN (CAST (substr(A0.date, 15, 2) AS DECIMAL) >= 45 AND 
                                        CAST (substr(A0.date, 15, 2) AS DECIMAL) < 60) THEN '45' ELSE '' END AS minuto5
                        FROM HISTORY A0,
                             VIEWHISTORY A1
                       WHERE A0.ticketroot = A1.ticket AND 
                             A0.ticket <> A0.ticketroot AND 
                             A0.type = 'ORDER_TYPE_SELL' AND 
                             A0.price = A1.takeprofit
                  )
                  AS MAIN
       )
       AS BEHIND,
       ViewchoiseBuyTrue BUY
 WHERE BEHIND.DATEROOT = BUY.date