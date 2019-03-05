USE [CollectionDev]

GO

SET ANSI_NULLS ON

GO

 

SET QUOTED_IDENTIFIER ON

GO
 
CREATE TABLE [CollectionDev].[dev01].Response

(

    Reference              Char(11) NOT NULL,

    Period                 Char(6) NOT NULL,

    Survey                 Char(3) NOT NULL,

    QuestionCode           Char(4) NOT NULL,

    Instance               Int NOT NULL,

    Response               Varchar(256) NOT NULL,

    CreatedBy              Varchar(16) NOT NULL,

    CreatedDate            DatetimeOffset(7) NOT NULL,

    LastUpdatedBy          Varchar(16),

    LastUpdatedDate        DatetimeOffset(7),

 

    CONSTRAINT ResponsePK PRIMARY KEY CLUSTERED (Reference, Period, Survey, QuestionCode, Instance),

 

    CONSTRAINT FK_Response_Contributor FOREIGN KEY (Reference, Period, Survey)

        REFERENCES [CollectionDev].[dev01].Contributor (Reference, Period, Survey)

        ON DELETE CASCADE

        ON UPDATE CASCADE

)

 

 

CREATE TABLE [CollectionDev].[dev01].ValidationRule

(

    ValidationRule  Varchar(16) NOT NULL,

    Name            Varchar(32) NOT NULL,

    Description     Varchar(128) NOT NULL,

    CreatedBy       Varchar(16) NOT NULL,

    CreatedDate     DatetimeOffset(7) NOT NULL,

    LastUpdatedBy   Varchar(16),

    LastUpdatedDate DatetimeOffset(7),

 

    CONSTRAINT ValidationRulePK PRIMARY KEY CLUSTERED (ValidationRule)

)

 

 

CREATE TABLE [CollectionDev].[dev01].ValidationForm

(

    ValidationID            Integer IDENTITY(1,1) NOT NULL,

    FormID                  BigInt NOT NULL,

    ValidationCode          Varchar(16) NOT NULL,

    QuestionCode            Varchar(4) NOT NULL,

    PreCalculationFormula   Varchar(256) NOT NULL,

    Severity                Varchar(16) NOT NULL,

    CreatedBy               Varchar(16) NOT NULL,

    CreatedDate             DatetimeOffset(7) NOT NULL,

    LastUpdatedBy           Varchar(16),

    LastUpdatedDate         DatetimeOffset(7),

 

    CONSTRAINT ValidationFormPK PRIMARY KEY CLUSTERED (ValidationID),

   

)

CREATE INDEX ValidationFormIX  On [CollectionDev].[dev01].ValidationForm (FormID, ValidationCode)

CREATE INDEX ValidationFormIX2 On [CollectionDev].[dev01].ValidationForm (QuestionCode)

 

CREATE TABLE [CollectionDev].[dev01].ValidationParameter

(

    ValidationID    BigInt NOT NULL,

    AttributeValue  Varchar(32) NOT NULL,

    Parameter       Varchar(32) NOT NULL,

    Value           Varchar(32) NOT NULL,

    CreatedBy       Varchar(16) NOT NULL,

    CreatedDate     DatetimeOffset(7) NOT NULL,

    LastUpdatedBy   Varchar(16),

    LastUpdatedDate DatetimeOffset(7),

 

    CONSTRAINT ValidationRulePK_validaiton_parameter PRIMARY KEY CLUSTERED (ValidationID, AttributeValue, Parameter)

)

 

 

CREATE TABLE [CollectionDev].[dev01].ValidationOutput

(

    ValidationOutputID Integer IDENTITY(1,1) NOT NULL,

    Reference       Varchar(11) NOT NULL,

    Period          Char(6) NOT NULL,

    Survey          Char(6) NOT NULL,

    ValidationID    BigInt NOT NULL,

    Instance        BigInt NOT NULL,

    PrimaryValue    Varchar(128) NOT NULL,

    Formula         Varchar(128) NOT NULL,

    CreatedBy       Varchar(16) NOT NULL,

    CreatedDate     DatetimeOffset(7) NOT NULL,

    LastUpdatedBy   Varchar(16),

    LastUpdatedDate DatetimeOffset(7),

 

    CONSTRAINT ValidationOutputPK PRIMARY KEY CLUSTERED (ValidationOutputID),

   

)

CREATE INDEX ValidationOutputIX On [CollectionDev].[dev01].ValidationOutput (Reference, Period, Survey)
