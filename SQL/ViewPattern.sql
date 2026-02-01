CREATE VIEW ViewPattern AS
    SELECT PATTERN
      FROM (
               SELECT DATE(substr(date, 1, 4) || '-' || substr(date, 6, 2) || '-' || substr(date, 9, 2) ) AS DATE_EVENT,
                      PATTERN,
                      DATE
                 FROM (
                          SELECT DISTINCT DATE,
                                          PATTERN
                            FROM Fault
                          UNION ALL
                          SELECT DISTINCT DATE,
                                          PATTERN
                            FROM Hit
                      )
                      PATTERN_ALL
           )
     GROUP BY PATTERN
     ORDER BY PATTERN;
