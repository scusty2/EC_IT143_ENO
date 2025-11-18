DROP TABLE IF EXISTS dbo.t_nyhousing;
GO

CREATE TABLE dbo.t_nyhousing
(
    [TYPE]             VARCHAR(50) NOT NULL,
    [PRICE]            MONEY NOT NULL,
    [BEDS]             INT NOT NULL,
    [BATH]             INT NOT NULL,
    [PROPERTYSQFT]     INT NOT NULL,
    [ADDRESS]          VARCHAR(100) NOT NULL,
    load_timestamp     DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_t_nyhousing PRIMARY KEY CLUSTERED ([ADDRESS] ASC)
);
GO