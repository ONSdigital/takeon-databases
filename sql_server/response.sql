USE [CollectionDev]

GO

 

SET ANSI_NULLS ON

GO

 

SET QUOTED_IDENTIFIER ON

GO

 

/* Create Schema dev01 */

/* ALTER USER [collection_user] With DEFAULT_SCHEMA = dev01; */

 

IF OBJECT_ID('Response', 'U') IS NOT NULL

    DROP TABLE Response;

 

CREATE TABLE [CollectionDev].[dev01].Response

(

    Reference              Char(11) NOT NULL,          -- e.g. 499000000123

    Period                 Char(6) NOT NULL,           -- e.g. 201512

    Survey                 Char(3) NOT NULL,           -- e.g. 061

    QuestionCode           Char(4) NOT NULL,           -- e.g. 0401

    Instance               Int NOT NULL,               -- Used for repeating data.

    Response               Varchar(256) NOT NULL,      -- The contents

    CreatedBy              Varchar(16) NOT NULL,       -- Derived [Determined when initially saved]

    CreatedDate            DatetimeOffset(7) NOT NULL, -- Derived [Determined when initially saved]

    LastUpdatedBy          Varchar(16),                -- Derived [Determined when updated]

    LastUpdatedDate        DatetimeOffset(7),          -- Derived [Determined when updated]

 

    CONSTRAINT PK_Response PRIMARY KEY CLUSTERED (Reference, Period, Survey, QuestionCode, Instance),

    CONSTRAINT FK_Response_Contributor FOREIGN KEY (Reference, Period, Survey)

        REFERENCES [CollectionDev].[dev01].Contributor (Reference, Period, Survey)

        ON DELETE CASCADE

        ON UPDATE CASCADE

)
