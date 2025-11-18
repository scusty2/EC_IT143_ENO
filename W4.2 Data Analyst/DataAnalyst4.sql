DROP TABLE IF EXISTS dbo.t_dataanalyst;
GO

CREATE TABLE dbo.t_dataanalyst
(
    [Job_Title]        VARCHAR(100) NOT NULL,
    [Company_Name]     VARCHAR(100) NOT NULL,
    [Rating]           DECIMAL(3,2) NOT NULL,
    [Salary_Estimate]  VARCHAR(50) NOT NULL,
    [Location]         VARCHAR(100) NOT NULL,
    load_timestamp     DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_t_dataanalyst PRIMARY KEY CLUSTERED ([Job_Title], [Company_Name])
);