SET IDENTITY_INSERT [CollectionDev].[dev01].Form ON

INSERT INTO [CollectionDev].[dev01].Form

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

    (1,'066','Quarterly Survey of Building Materials - Sand and Gravel (land-won)', '200903','999912', CURRENT_USER, GETDATE()),

    (2,'076','Quarterly Survey of Building Materials - Sand and Gravel (marine dredged)', '200903','999912', CURRENT_USER, GETDATE()),

    (3,'073','Monthly Survey of Building Materials - Concrete Building Blocks', '200901','999912', CURRENT_USER, GETDATE()),

    (4,'074','Monthly Survey of Building Materials - Bricks', '200901','999912', CURRENT_USER, GETDATE())

 
            

               


INSERT INTO [CollectionDev].[dev01].FormDefinition

(

                FormID,

    QuestionCode,

    DisplayQuestionNumber,

    DisplayText,

    Type,

    CreatedBy,

    CreatedDate        

)

VALUES 

 

    (1,'601','1','Sand produced for asphalt (asphalting sand)','NUMERIC',CURRENT_USER, GETDATE()),

    (1,'602','2','Sand produced for use in mortar (building or soft sand)','NUMERIC',CURRENT_USER, GETDATE()),

    (1,'603','3','Sand produced for concreting (sharp sand)','NUMERIC',CURRENT_USER, GETDATE()),

    (1,'604','4','Gravel coated with bituminous binder (on or off site)','NUMERIC',CURRENT_USER, GETDATE()),

    (1,'605','5','Gravel produced for concrete aggregate (including sand/gravel mixes)','NUMERIC',CURRENT_USER, GETDATE()),

    (1,'606','6','Other screened and graded gravels','NUMERIC',CURRENT_USER, GETDATE()),

    (1,'607','7','Sand and gravel used for construction fill','NUMERIC',CURRENT_USER, GETDATE()),

    (1,'608','8','TOTALS','NUMERIC',CURRENT_USER, GETDATE()),

    (1,'147','9','New pits or quarries brought into use since date of last return','TICKBOX-YESNO',CURRENT_USER, GETDATE()),

    (1,'146','10','Remarks','TICKBOX-YESNO',CURRENT_USER, GETDATE()),

               

    (2,'601','1','Sand produced for asphalt (asphalting sand)','NUMERIC',CURRENT_USER, GETDATE()),

    (2,'602','2','Sand produced for use in mortar (building or soft sand)','NUMERIC',CURRENT_USER, GETDATE()),

    (2,'603','3','Sand produced for concreting (sharp sand)','NUMERIC',CURRENT_USER, GETDATE()),

    (2,'604','4','Gravel coated with bituminous binder (on or off site)','NUMERIC',CURRENT_USER, GETDATE()),

    (2,'605','5','Gravel produced for concrete aggregate (including sand/gravel mixes)','NUMERIC',CURRENT_USER, GETDATE()),

    (2,'606','6','Other screened and graded gravels','NUMERIC',CURRENT_USER, GETDATE()),

    (2,'607','7','Sand and gravel used for construction fill','NUMERIC',CURRENT_USER, GETDATE()),

    (2,'608','8','TOTALS','NUMERIC',CURRENT_USER, GETDATE()),

    (2,'148','9','New pits or quarries brought into use since date of last return','TICKBOX-YESNO',CURRENT_USER, GETDATE()),

    (2,'146','10','Remarks','TICKBOX-YESNO',CURRENT_USER, GETDATE()),

               

                (3,'101','1','Dense Aggregate - Opening stock','NUMERIC',CURRENT_USER, GETDATE()),

                (3,'102','2','Dense Aggregate - Total production during month','NUMERIC',CURRENT_USER, GETDATE()),

                (3,'103','3','Dense Aggregate - Total deliveries during month','NUMERIC',CURRENT_USER, GETDATE()),

                (3,'104','4','Dense Aggregate - Total production during month','NUMERIC',CURRENT_USER, GETDATE()),

                (3,'111','5','Lightweight Aggregate - Opening stock','NUMERIC',CURRENT_USER, GETDATE()),

    (3,'112','6','Lightweight Aggregate - Total production during month','NUMERIC',CURRENT_USER, GETDATE()),

    (3,'113','7','Lightweight Aggregate - Total deliveries during month','NUMERIC',CURRENT_USER, GETDATE()),

    (3,'114','8','Lightweight Aggregate - Closing stock','NUMERIC',CURRENT_USER, GETDATE()),

    (3,'121','9','Aerated - Opening stock','NUMERIC',CURRENT_USER, GETDATE()),

    (3,'122','10','Aerated - Total production during month','NUMERIC',CURRENT_USER, GETDATE()),

    (3,'123','11','Aerated - Total deliveries during month','NUMERIC',CURRENT_USER, GETDATE()),

    (3,'124','12','Aerated - Closing stock','NUMERIC',CURRENT_USER, GETDATE()),

    (3,'145','13','New works brought into use since date of last return','TICKBOX-YESNO',CURRENT_USER, GETDATE()),

    (3,'146','14','Remarks','TICKBOX-YESNO',CURRENT_USER, GETDATE()),

               

    (4,'01','1','Opening Stock - Commons','NUMERIC',CURRENT_USER, GETDATE()),

    (4,'11','2','Opening Stock - Facings','NUMERIC',CURRENT_USER, GETDATE()),

    (4,'21','3','Opening Stock - Engineering','NUMERIC',CURRENT_USER, GETDATE()),

    (4,'501','4','Opening Stock - Total','NUMERIC',CURRENT_USER, GETDATE()),

    (4,'02','5','Drawn from kiln during month - Commons','NUMERIC',CURRENT_USER, GETDATE()),

    (4,'12','6','Drawn from kiln during month - Facings','NUMERIC',CURRENT_USER, GETDATE()),

    (4,'22','7','Drawn from kiln during month - Engineering','NUMERIC',CURRENT_USER, GETDATE()),

    (4,'502','8','Drawn from kiln during month - Total','NUMERIC',CURRENT_USER, GETDATE()),

    (4,'03','9','Deliveries to customers during month - Commons','NUMERIC',CURRENT_USER, GETDATE()),

    (4,'13','10','Deliveries to customers during month - Facings','NUMERIC',CURRENT_USER, GETDATE()),

    (4,'23','11','Deliveries to customers during month - Engineering','NUMERIC',CURRENT_USER, GETDATE()),

    (4,'503','12','Deliveries to customers during month - Total','NUMERIC',CURRENT_USER, GETDATE()),

    (4,'04','13','Closing stock - Commons','NUMERIC',CURRENT_USER, GETDATE()),

    (4,'14','14','Closing stock - Facings','NUMERIC',CURRENT_USER, GETDATE()),

    (4,'24','15','Closing stock - Engineering','NUMERIC',CURRENT_USER, GETDATE()),

    (4,'504','16','Closing stock - Total','NUMERIC',CURRENT_USER, GETDATE()),

    (4,'00','17','Brick type','NUMERIC',CURRENT_USER, GETDATE()),

    (4,'145','18','New works brought into use since date of last return','TICKBOX-YESNO',CURRENT_USER, GETDATE()),

    (4,'146','19','Remarks','TICKBOX-YESNO',CURRENT_USER, GETDATE())
