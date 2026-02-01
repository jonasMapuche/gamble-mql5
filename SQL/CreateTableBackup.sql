CREATE TABLE History_Backup (
    date       TEXT NOT NULL,
    ticket     TEXT NOT NULL,
    type       TEXT NOT NULL,
    symbol     TEXT NOT NULL,
    state      TEXT NOT NULL,
    price      TEXT NOT NULL,
    takeprofit TEXT NOT NULL,
    stoploss   TEXT NOT NULL,
    volume     TEXT NOT NULL,
    ticketroot TEXT NOT NULL,
    date_carga TEXT NOT NULL
);

CREATE TABLE Hit_Backup (
    date       TEXT NOT NULL,
    symbol     TEXT NOT NULL,
    pattern    TEXT NOT NULL,
    date_time  TEXT NOT NULL,
    date_carga TEXT NOT NULL
);

CREATE TABLE Fault_Backup (
    date       TEXT NOT NULL,
    symbol     TEXT NOT NULL,
    pattern    TEXT NOT NULL,
    date_time  TEXT NOT NULL,
    date_carga TEXT NOT NULL
);

CREATE TABLE Choise_Backup (
    date      TEXT NOT NULL,
    symbol    TEXT NOT NULL,
    pattern   TEXT NOT NULL,
    date_time TEXT NOT NULL,
    value     TEXT NOT NULL,
    state     TEXT NOT NULL,
    volume    TEXT NOT NULL,
    date_cara TEXT NOT NULL
);
