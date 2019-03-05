USE [CollectionDev]

INSERT INTO [dev01].[ValidationForm] (FormID, ValidationCode, QuestionCode, PreCalculationFormula, Severity, 
CreatedBy, CreatedDate) values
	(1, 'VP', 146, 'Q146 != ''''', 'E', 'fisdba', getdate()),
	(1, 'VP', 147, 'Q147 != ''''', 'W', 'fisdba', getdate()),
	(2, 'VP', 601, 'Q601 != ''''', 'E', 'fisdba', getdate()),
	(2, 'VP', 148, 'Q148 != ''''', 'W', 'fisdba', getdate()),
	(3, 'VP', 101, 'Q101 != ''''', 'E', 'fisdba', getdate()),
	(3, 'VP', 112, 'Q122 != ''''', 'E', 'fisdba', getdate()),
	(3, 'VP', 146, 'Q146 != ''''', 'W', 'fisdba', getdate()),
	(4, 'VP', '01', 'Q01 != ''''', 'W', 'fisdba', getdate()),
	(4, 'VP', 502, 'Q502 != ''''', 'E', 'fisdba', getdate())
