CREATE DATABASE CollectionDev;
\c collectiondev;
SET search_path TO dev01,public;

Create Table Survey
(
    survey              varchar(4) Primary Key,
    description         varchar(128) Not Null,
    periodicity         varchar(32) Not Null,
    CreatedBy           Varchar(16) Not Null,
    CreatedDate         timestamptz Not Null,
    LastUpdatedBy       Varchar(16),
    LastUpdatedDate     timestamptz
);


Create Table Form
(
    FormID              Serial Primary Key,
    Survey              Varchar(4) References Survey(Survey),
    Description         Varchar(128) Not Null,
    PeriodStart         Varchar(6) Not Null,
    PeriodEnd           Varchar(6) Not Null,
    CreatedBy           Varchar(16) Not Null,
    CreatedDate         timestamptz Not Null,
    LastUpdatedBy       Varchar(16),
    LastUpdatedDate     timestamptz
);


Create Table Question
(
    Survey              Varchar(4) References Survey(Survey),
    QuestionCode        Varchar(8) Not Null,
    CreatedBy           Varchar(16) Not Null,
    CreatedDate         timestamptz Not Null,
    LastUpdatedBy       Varchar(16),
    LastUpdatedDate     timestamptz,
    
    Primary Key (Survey, QuestionCode)
);


Create Table FormDefinition
(
    FormID                  serial References Form(FormID),
    QuestionCode            Varchar(8) Not Null,
    DisplayQuestionNumber   Varchar(16) Not Null,
    DisplayText             Varchar(128) Not Null,
    DisplayOrder            Integer Not Null,
    Type                    Varchar(16) Not Null,
    DerivedFormula          Varchar(128) Not Null,
    CreatedBy               Varchar(16) Not Null,
    CreatedDate             timestamptz Not Null,
    LastUpdatedBy           Varchar(16),       
    LastUpdatedDate         timestamptz, 

    Primary Key (FormID, QuestionCode)
);
Create Index idx_formdefinition_question On FormDefinition(QuestionCode);


Create Table Contributor
(
    Reference                   Varchar(11) Not Null,
    Period                      Char(6) Not Null,
    Survey                      Char(4) References Survey(Survey),
    FormID                      Integer References Form(FormID),
    Status                      Varchar(20) Not Null,
    ReceiptDate                 timestamptz,
    LockedBy                    Varchar(16),
    LockedDate                  timestamptz,
    FormType                    Char(4) Not Null,
    Checkletter                 Char(1) Not Null,
    FrozenSicOutdated           Char(5) Not Null,
    RuSicOutdated               Char(5) Not Null,
    FrozenSic                   Char(5) Not Null,
    RuSic                       Char(5) Not Null,
    FrozenEmployees             Decimal(13,0) Not Null,
    Employees                   Decimal(13,0) Not Null,
    FrozenEmployment            Decimal(13,0) Not Null,
    Employment                  Decimal(13,0) Not Null,
    FrozenFteEmployment         Decimal(10,3) Not Null,
    FteEmployment               Decimal(10,3) Not Null,
    FrozenTurnover              Decimal(13,0) Not Null,
    Turnover                    Decimal(13,0) Not Null,
    EnterpriseReference         Char(10) Not Null,
    WowEnterpriseReference      Varchar(10) Not Null,
    CellNumber                  SmallInt Not Null,
    Currency                    Char(1) Not Null,
    VatReference                Varchar(12) Not Null,
    PayeReference               Varchar(13) Not Null,
    CompanyRegistrationNumber   Varchar(8) Not Null,
    NumberLiveLocalUnits        Decimal(6,0) Not Null,
    NumberLiveVat               Decimal(6,0) Not Null,
    NumberLivePaye              Decimal(6,0) Not Null,
    LegalStatus                 Char(1) Not Null,
    ReportingUnitMarker         Char(1) Not Null,
    Region                      Char(2) Not Null,
    BirthDate                   Varchar(16) NULL,
    EnterpriseName              Varchar(107) Not Null,
    ReferenceName               Varchar(107) Not Null,
    ReferenceAddress            Varchar(154) Not Null,
    ReferencePostcode           Varchar(8) Not Null,
    TradingStyle                Varchar(107) Not Null,
    Contact                     Varchar(30) Not Null,
    Telephone                   Varchar(20) Not Null,
    Fax                         Varchar(20) Not Null,
    SelectionType               Char(1) Not Null,
    InclusionExclusion          Char(1) Not Null,
    CreatedBy                   Varchar(16) Not Null,
    CreatedDate                 timestamptz Not Null,
    LastUpdatedBy               Varchar(16),
    LastUpdatedDate             timestamptz,
    
    Primary Key (reference, period, survey)
);
Create Index idx_contributor_periodsurvey On Contributor(period, survey);
Create Index idx_contributor_surveyreference On Contributor(survey, reference);


Create Table Response
(
    Reference              Char(11) Not Null,
    Period                 Char(6) Not Null,
    Survey                 Char(3) References Survey(Survey),
    QuestionCode           Char(4) Not Null,
    Instance               Int Not Null,
    Response               Varchar(256) Not Null,
    CreatedBy              Varchar(16) Not Null,
    CreatedDate            timestamptz Not Null,
    LastUpdatedBy          Varchar(16),
    LastUpdatedDate        timestamptz,
    Primary Key (Reference, Period, Survey, QuestionCode, Instance),
    Foreign Key (Reference, Period, Survey) References Contributor (Reference, Period, Survey),
    Foreign Key (Survey, QuestionCode) References Question (Survey, QuestionCode)
);


Create Table ValidationRule
(
    Rule            Varchar(16) Primary Key,
    Name            Varchar(32) Not Null,
    BaseFormula     Varchar(1024) Not Null,
    CreatedBy       Varchar(16) Not Null,
    CreatedDate     timestamptz Not Null,
    LastUpdatedBy   Varchar(16),
    LastUpdatedDate timestamptz
);


Create Table ValidationPeriod
(
    Rule            Varchar(16) References ValidationRule(Rule),
    PeriodOffset    Integer Not Null,
    CreatedBy       Varchar(16) Not Null,
    CreatedDate     timestamptz Not Null,
    LastUpdatedBy   Varchar(16),
    LastUpdatedDate timestamptz,
    Primary Key (Rule,PeriodOffset)
);


Create Table ValidationForm
(
    ValidationID            serial Primary Key,
    FormID                  Int References Form(FormID),
    Rule                    Varchar(16) References ValidationRule(Rule),
    QuestionCode            Varchar(4) Not Null,
    PreCalculationFormula   Varchar(256) Not Null,
    Severity                Varchar(16) Not Null,
    CreatedBy               Varchar(16) Not Null,
    CreatedDate             timestamptz Not Null,
    LastUpdatedBy           Varchar(16),
    LastUpdatedDate         timestamptz
);
Create Index idx_validationform_formrule On ValidationForm(FormID,Rule);
Create Index idx_validationform_question On ValidationForm(QuestionCode);


Create Table ValidationAttribute
(
    AttributeName   Varchar(32) Primary Key,
    Source          Varchar(32) Not Null,
    CreatedBy       Varchar(16) Not Null,
    CreatedDate     timestamptz Not Null,
    LastUpdatedBy   Varchar(16),
    LastUpdatedDate timestamptz
);


Create Table ValidationParameter
(
    ValidationID    Int References ValidationForm(ValidationID),
    AttributeName   Varchar(32) References ValidationAttribute(AttributeName),
    AttributeValue  Varchar(32) Not Null,
    Parameter       Varchar(32) Not Null,
    Value           Varchar(32) Not Null,
    CreatedBy       Varchar(16) Not Null,
    CreatedDate     timestamptz Not Null,
    LastUpdatedBy   Varchar(16),
    LastUpdatedDate timestamptz,
    Primary Key (ValidationID, AttributeName, AttributeValue, Parameter)
);


Create Table ValidationOutput
(
    ValidationOutputID  serial Primary Key,
    Reference           Varchar(11) Not Null,
    Period              Char(6) Not Null,
    Survey              Char(6) References Survey(Survey),
    ValidationID        BigInt References ValidationForm(ValidationID),
    Instance            BigInt Not Null,
    PrimaryValue        Varchar(128) Not Null,
    Formula             Varchar(128) Not Null,
    CreatedBy           Varchar(16) Not Null,
    CreatedDate         timestamptz Not Null,
    LastUpdatedBy       Varchar(16),
    LastUpdatedDate     timestamptz,
    Foreign Key (Reference, Period, Survey) References Contributor (Reference, Period, Survey)
);
Create Index idx_validationoutput_referenceperiodsurvey On ValidationOutput(Reference, Period, Survey);

Delete From Survey;
Insert Into Survey
(
    survey,
    description,
    periodicity,
    CreatedBy,
    CreatedDate    
)
Values
    ( '066', 'Sand & Gravel - Land', 'quarterly', current_user, Now()),
    ( '076', 'Sand & Gravel - Marine', 'quarterly', current_user, Now()),
    ( '073', 'Building Materials - Blocks', 'monthly', current_user, Now()),
    ( '074', 'Building Materials - Bricks', 'monthly', current_user, Now());
    

Delete From Form
Where   FormID In (1,2,3,4);

Insert Into Form
(
    FormID,
    Survey,
    Description,
    PeriodStart,
    PeriodEnd,
    CreatedBy,
    CreatedDate    
)
VALUES 
    (1,'066','Quarterly Survey of Building Materials - Sand and Gravel (land-won)', '200903','999912', current_user, Now()),
    (2,'076','Quarterly Survey of Building Materials - Sand and Gravel (marine dredged)', '200903','999912', current_user, Now()),
    (3,'073','Monthly Survey of Building Materials - Concrete Building Blocks', '200901','999912', current_user, Now()), 
    (4,'074','Monthly Survey of Building Materials - Bricks', '200901','999912', current_user, Now());
                         
Delete From FormDefinition
Where FormID In (1,2,3,4);


Insert Into FormDefinition
(
    FormID,
    QuestionCode,
    DisplayQuestionNumber,
    DisplayOrder,
    DerivedFormula,
    DisplayText,
    Type,
    CreatedBy,
    CreatedDate         
)
VALUES  
    (1,'601','1',10,'','Sand produced for asphalt (asphalting sand)','NUMERIC',current_user, Now()),
    (1,'602','2',20,'','Sand produced for use in mortar (building or soft sand)','NUMERIC',current_user, Now()),
    (1,'603','3',30,'','Sand produced for concreting (sharp sand)','NUMERIC',current_user, Now()),
    (1,'604','4',40,'','Gravel coated with bituminous binder (on or off site)','NUMERIC',current_user, Now()),
    (1,'605','5',50,'','Gravel produced for concrete aggregate (including sand/gravel mixes)','NUMERIC',current_user, Now()),
    (1,'606','6',60,'','Other screened and graded gravels','NUMERIC',current_user, Now()),
    (1,'607','7',70,'','Sand and gravel used for construction fill','NUMERIC',current_user, Now()),
    (1,'608','8',80,'','TOTALS','NUMERIC',current_user, Now()),
    (1,'147','9',90,'','New pits or quarries brought into use since date of last return','TICKBOX-YESNO',current_user, Now()),
    (1,'146','10',100,'','Remarks','TICKBOX-YESNO',current_user, Now()),
                
    (2,'601','1',10,'','Sand produced for asphalt (asphalting sand)','NUMERIC',current_user, Now()),
    (2,'602','2',20,'','Sand produced for use in mortar (building or soft sand)','NUMERIC',current_user, Now()),
    (2,'603','3',30,'','Sand produced for concreting (sharp sand)','NUMERIC',current_user, Now()),
    (2,'604','4',40,'','Gravel coated with bituminous binder (on or off site)','NUMERIC',current_user, Now()),
    (2,'605','5',50,'','Gravel produced for concrete aggregate (including sand/gravel mixes)','NUMERIC',current_user, Now()),
    (2,'606','6',60,'','Other screened and graded gravels','NUMERIC',current_user, Now()),
    (2,'607','7',70,'','Sand and gravel used for construction fill','NUMERIC',current_user, Now()),
    (2,'608','8',80,'','TOTALS','NUMERIC',current_user, Now()),
    (2,'148','9',90,'','New pits or quarries brought into use since date of last return','TICKBOX-YESNO',current_user, Now()),
    (2,'146','10',100,'','Remarks','TICKBOX-YESNO',current_user, Now()),
                
    (3,'101','1',10,'','Dense Aggregate - Opening stock','NUMERIC',current_user, Now()),
    (3,'102','2',20,'','Dense Aggregate - Total production during month','NUMERIC',current_user, Now()),
    (3,'103','3',30,'','Dense Aggregate - Total deliveries during month','NUMERIC',current_user, Now()),
    (3,'104','4',40,'','Dense Aggregate - Total production during month','NUMERIC',current_user, Now()),
    (3,'111','5',50,'','Lightweight Aggregate - Opening stock','NUMERIC',current_user, Now()),
    (3,'112','6',60,'','Lightweight Aggregate - Total production during month','NUMERIC',current_user, Now()),
    (3,'113','7',70,'','Lightweight Aggregate - Total deliveries during month','NUMERIC',current_user, Now()),
    (3,'114','8',80,'','Lightweight Aggregate - Closing stock','NUMERIC',current_user, Now()),
    (3,'121','9',90,'','Aerated - Opening stock','NUMERIC',current_user, Now()),
    (3,'122','10',100,'','Aerated - Total production during month','NUMERIC',current_user, Now()),
    (3,'123','11',110,'','Aerated - Total deliveries during month','NUMERIC',current_user, Now()),
    (3,'124','12',120,'','Aerated - Closing stock','NUMERIC',current_user, Now()),
    (3,'145','13',130,'','New works brought into use since date of last return','TICKBOX-YESNO',current_user, Now()),
    (3,'146','14',140,'','Remarks','TICKBOX-YESNO',current_user, Now()),
            
    (4,'01','1',10,'','Opening Stock - Commons','NUMERIC',current_user, Now()),
    (4,'11','2',20,'','Opening Stock - Facings','NUMERIC',current_user, Now()),
    (4,'21','3',30,'','Opening Stock - Engineering','NUMERIC',current_user, Now()),
    (4,'501','4',40,'','Opening Stock - Total','NUMERIC',current_user, Now()),
    (4,'02','5',50,'','Drawn from kiln during month - Commons','NUMERIC',current_user, Now()),
    (4,'12','6',60,'','Drawn from kiln during month - Facings','NUMERIC',current_user, Now()),
    (4,'22','7',70,'','Drawn from kiln during month - Engineering','NUMERIC',current_user, Now()),
    (4,'502','8',80,'','Drawn from kiln during month - Total','NUMERIC',current_user, Now()),
    (4,'03','9',90,'','Deliveries to customers during month - Commons','NUMERIC',current_user, Now()),
    (4,'13','10',100,'','Deliveries to customers during month - Facings','NUMERIC',current_user, Now()),
    (4,'23','11',110,'','Deliveries to customers during month - Engineering','NUMERIC',current_user, Now()),
    (4,'503','12',120,'','Deliveries to customers during month - Total','NUMERIC',current_user, Now()),
    (4,'04','13',130,'','Closing stock - Commons','NUMERIC',current_user, Now()),
    (4,'14','14',140,'','Closing stock - Facings','NUMERIC',current_user, Now()),
    (4,'24','15',150,'','Closing stock - Engineering','NUMERIC',current_user, Now()),
    (4,'504','16',160,'','Closing stock - Total','NUMERIC',current_user, Now()),
    (4,'00','17',170,'','Brick type','NUMERIC',current_user, Now()),
    (4,'145','18',180,'','New works brought into use since date of last return','TICKBOX-YESNO',current_user, Now()),
    (4,'146','19',190,'','Remarks','TICKBOX-YESNO',current_user, Now());
    

Delete From Question;
Insert Into Question
(
    Survey,
    QuestionCode,
    CreatedBy,
    CreatedDate
)
Values
    ('066','601',current_user, Now()),
    ('066','602',current_user, Now()),
    ('066','603',current_user, Now()),
    ('066','604',current_user, Now()),
    ('066','605',current_user, Now()),
    ('066','606',current_user, Now()),
    ('066','607',current_user, Now()),
    ('066','608',current_user, Now()),
    ('066','147',current_user, Now()),
    ('066','146',current_user, Now()),
    ('076','601',current_user, Now()),
    ('076','602',current_user, Now()),
    ('076','603',current_user, Now()),
    ('076','604',current_user, Now()),
    ('076','605',current_user, Now()),
    ('076','606',current_user, Now()),
    ('076','607',current_user, Now()),
    ('076','608',current_user, Now()),
    ('076','148',current_user, Now()),
    ('076','146',current_user, Now()),
    ('073','101',current_user, Now()),
    ('073','102',current_user, Now()),
    ('073','103',current_user, Now()),
    ('073','104',current_user, Now()),
    ('073','111',current_user, Now()),
    ('073','112',current_user, Now()),
    ('073','113',current_user, Now()),
    ('073','114',current_user, Now()),
    ('073','121',current_user, Now()),
    ('073','122',current_user, Now()),
    ('073','123',current_user, Now()),
    ('073','124',current_user, Now()),
    ('073','145',current_user, Now()),
    ('073','146',current_user, Now()),
    ('074','01',current_user, Now()),
    ('074','11',current_user, Now()),
    ('074','21',current_user, Now()),
    ('074','501',current_user, Now()),
    ('074','02',current_user, Now()),
    ('074','12',current_user, Now()),
    ('074','22',current_user, Now()),
    ('074','502',current_user, Now()),
    ('074','03',current_user, Now()),
    ('074','13',current_user, Now()),
    ('074','23',current_user, Now()),
    ('074','503',current_user, Now()),
    ('074','04',current_user, Now()),
    ('074','14',current_user, Now()),
    ('074','24',current_user, Now()),
    ('074','504',current_user, Now()),
    ('074','00',current_user, Now()),
    ('074','145',current_user, Now()),
    ('074','146',current_user, Now());
   

Insert Into Contributor
(
    Reference,
    Period,
    Survey,
    FormID,
    Status,
    ReceiptDate,
    FormType,
    Checkletter,
    FrozenSicOutdated,
    RuSicOutdated,
    FrozenSic,
    RuSic,
    FrozenEmployees,
    Employees,
    FrozenEmployment,
    Employment,
    FrozenFteEmployment,
    FteEmployment,
    FrozenTurnover,
    Turnover,
    EnterpriseReference,
    WowEnterpriseReference,
    CellNumber,
    Currency,
    VatReference,
    PayeReference,
    CompanyRegistrationNumber,
    NumberLiveLocalUnits,
    NumberLiveVat,
    NumberLivePaye,
    LegalStatus,
    ReportingUnitMarker,
    Region,
    BirthDate,
    EnterpriseName,
    ReferenceName,
    ReferenceAddress,
    ReferencePostcode,
    TradingStyle,
    Contact,
    Telephone,
    Fax  ,
    SelectionType,
    InclusionExclusion,
    CreatedBy,
    CreatedDate
)
Values
    ( '4990012','201211','066',1,'Form Saved',now(),'0001','X','69091','69091','69091','69091',0,0,0,0,0,0,0,0,'','',0,'S','','','',0,0,0,'','','','','','','','','','','','','','',current_user,now()),
    ( '4990012','201212','066',1,'Form Saved',now(),'0001','X','69091','69091','69091','69091',0,0,0,0,0,0,0,0,'','',0,'S','','','',0,0,0,'','','','','','','','','','','','','','',current_user,now()),
    ( '4990065','201309','076',2,'Form Saved',now(),'0001','X','69091','69091','69091','69091',0,0,0,0,0,0,0,0,'','',0,'S','','','',0,0,0,'','','','','','','','','','','','','','',current_user,now());



    
Insert Into Response
(
    Reference,
    Period,
    Survey,
    QuestionCode,
    Instance,
    Response,
    CreatedBy,
    CreatedDate    
)
Values
    ( '4990012','201211','066','601',0,'21321',current_user,now()),
    ( '4990012','201211','066','602',0,'56547',current_user,now()),
    ( '4990012','201211','066','603',0,'567',current_user,now()),
    ( '4990012','201211','066','604',0,'34562',current_user,now()),
    ( '4990012','201211','066','605',0,'67',current_user,now()),
    ( '4990012','201211','066','606',0,'',current_user,now()),
    ( '4990012','201212','066','601',0,'123',current_user,now()),
    ( '4990012','201212','066','603',0,'11123123',current_user,now()),
    ( '4990012','201212','066','604',0,'9855',current_user,now()),
    ( '4990012','201212','066','607',0,'3489648',current_user,now()),
    ( '4990065','201309','076','602',0,'Eggs',current_user,now());


Insert Into ValidationRule
(
    Rule,
    Name,
    BaseFormula,
    CreatedBy,
    CreatedDate
)
Values
    ( 'VP','Value Present','QuestionCode != ""',current_user,now()),
    ( 'POPM','Period on Period Movement','((abs(QuestionCode - comparisonQuestion) * 100 / QuestionCode > incThreshold AND abs(QuestionCode - comparisonQuestion) > incValue) OR (abs(QuestionCode - comparisonQuestion) * 100 / QuestionCode > decThreshold AND abs(comparisonQuestion - QuestionCode) > decValue))',current_user,now()),
    ( 'POPZC','Value Present','Formula here',current_user,now()),
    ( 'QvDQ','Value Present','QuestionCode != DerivedQuestion',current_user,now());
    

Delete From ValidationPeriod;
Insert Into ValidationPeriod
(
    Rule,
    PeriodOffset,
    CreatedBy,
    CreatedDate
)
Values
    ('VP',0,current_user,now()),
    ('POPM',0,current_user,now()),
    ('POPM',1,current_user,now()),    
    ('POPZC',0,current_user,now()),
    ('POPZC',1,current_user,now()),
    ('QvDQ',0,current_user,now());


Delete From ValidationForm;
Insert Into ValidationForm
(
    ValidationID,
    FormID,
    Rule,
    QuestionCode,
    PreCalculationFormula,
    Severity,
    CreatedBy,
    CreatedDate
)
Values
    (1,1,'VP','601','','W',current_user,now()),
    (2,1,'VP','602','','W',current_user,now()),
    (3,1,'VP','603','','W',current_user,now()),
    (4,1,'VP','604','','W',current_user,now()),
    (5,1,'POPM','602','','W',current_user,now()),
    (6,1,'POPM','603','','W',current_user,now()),
    (7,1,'POPM','604','','W',current_user,now()),
    (8,1,'POPM','606','','W',current_user,now()),
    (9,2,'VP','607','','W',current_user,now());
    

Delete From ValidationAttribute;
Insert Into ValidationAttribute
(
    AttributeName,
    Source,    
    CreatedBy,
    CreatedDate
)
Values
    ('Default','N/A',current_user,now()),
    ('Region','contributor',current_user,now());
    
    
Insert Into ValidationParameter
(
    ValidationID,
    AttributeName,
    AttributeValue,
    Parameter,
    Value,
    CreatedBy,
    CreatedDate
)
Values
    (5,'Default','Default','incThreshold','10',current_user,now()),
    (5,'Default','Default','decThreshold','15',current_user,now()),
    (5,'Default','Default','incValue','25',current_user,now()),
    (5,'Default','Default','decValue','30',current_user,now()),
    (5,'Region','XX','incThreshold','20',current_user,now()),
    (5,'Region','XX','decThreshold','35',current_user,now()),
    (5,'Region','XX','incValue','85',current_user,now()),
    (5,'Region','XX','decValue','60',current_user,now()),    
    (6,'Default','Default','incThreshold','10',current_user,now()),
    (6,'Default','Default','decThreshold','15',current_user,now()),
    (6,'Default','Default','incValue','25',current_user,now()),
    (6,'Default','Default','decValue','30',current_user,now()),    
    (7,'Default','Default','incThreshold','18',current_user,now()),
    (7,'Default','Default','decThreshold','12',current_user,now()),
    (7,'Default','Default','incValue','27',current_user,now()),
    (7,'Default','Default','decValue','38',current_user,now()),        
    (8,'Default','Default','incThreshold','11',current_user,now()),
    (8,'Default','Default','decThreshold','16',current_user,now()),
    (8,'Default','Default','incValue','26',current_user,now()),
    (8,'Default','Default','decValue','31',current_user,now());    
