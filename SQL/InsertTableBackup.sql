INSERT INTO History_Backup (
    date,
    ticket,
    type,
    symbol,
    state,
    price,
    takeprofit,
    stoploss,
    volume,
    ticketroot,
    date_carga
)
SELECT date,
    ticket,
    type,
    symbol,
    state,
    price,
    takeprofit,
    stoploss,
    volume,
    ticketroot,
    '2024.04.25 19:35'
FROM History;

INSERT INTO Hit_Backup (
    date,
    symbol,
    pattern,
    date_time,
    date_carga
)
SELECT date,
    symbol,
    pattern,
    date_time,
    '2024.04.25 19:35'
FROM Hit;

INSERT INTO Fault_Backup (
    date,
    symbol,
    pattern,
    date_time,
    date_carga
)
SELECT date,
    symbol,
    pattern,
    date_time,
    '2024.04.25 19:35'
FROM Fault;

INSERT INTO Choise_Backup (
    date,
    symbol,
    pattern,
    date_time,
    value,
    state,
    volume,
    date_cara
)
SELECT date,
    symbol,
    pattern,
    date_time,
    value,
    state,
    volume,
    '2024.04.25 19:35'
FROM Choise;





