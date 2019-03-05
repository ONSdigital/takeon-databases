DECLARE @CounterVar Integer
SET @CounterVar = 0

CREATE TABLE #holderTable
(
	ID INT IDENTITY(1, 1),
	Reference char(11),
	Period char(6),
	Survey char(3),
	FormID BigInt,
	QuestionCode char(4),
	Response varchar(256),
	Instance int

)

CREATE TABLE #insertTable
(
	Reference char(11),
	Period	char(6),
	Survey char(3),
	FormID BigInt,
	QuestionCode char(4),
	Response varchar(256),
	Severity char(1),
	Instance int

)

Insert into #holderTable
select Reference, [Period], [Survey], JFor as FormID, QuestionCode, Response, Instance  from
(select joined.Reference as JRef, joined.[Period] as JPer, joined.[Survey] as JSur, joined.[FormID] as JFor from
	(select 
	cont.Reference, 
	cont.[Period], 
	cont.[Survey], 
	cont.[FormID] from [CollectionDev].[dev01].Contributor cont
	INNER JOIN [CollectionDev].[dev01].Form Form
	on Form.[FormID] = cont.[FormID] and Form.[Survey] = cont.[Survey]) 
	as joined ) 
	as contribs
	INNER JOIN [CollectionDev].[dev01].Response resp on 
	contribs.JRef = resp.[Reference] 
	and contribs.JPer = resp.[Period] 
	and contribs.JSur = resp.[Survey]

WHILE  @CounterVar < (Select count(*) from #holderTable)
BEGIN
	if ABS(CHECKSUM(NEWID()) % 10) > 7  AND ABS(CHECKSUM(NEWID()) % 10) > 6
		BEGIN
		INSERT INTO #insertTable (Reference, Period, Survey, FormID, QuestionCode, Response, Severity, Instance) 
		SELECT Reference, Period, Survey, FormID, QuestionCode, Response, 'E', Instance FROM #holderTable WHERE ID = @CounterVar and Response != ''
		SET @CounterVar = @CounterVar + 1
		END
	ELSE IF ABS(CHECKSUM(NEWID()) % 10) > 7  AND ABS(CHECKSUM(NEWID()) % 10) < 6
		BEGIN
		INSERT INTO #insertTable (Reference, Period, Survey, FormID, QuestionCode, Response, Severity, Instance) 
		SELECT Reference, Period, Survey, FormID, QuestionCode, Response, 'W', Instance FROM #holderTable WHERE ID = @CounterVar and Response != ''
		SET @CounterVar = @CounterVar + 1
		END
	SET @CounterVar = @CounterVar + 1
END

select * from #insertTable

INSERT INTO [CollectionDev].[dev01].[ValidationOutput] ([Reference], Period, Survey, Instance, ValidationID, PrimaryValue, Formula, CreatedBy, CreatedDate)
SELECT it.Reference, it.Period, it.Survey, it.Instance as Instance, vf.validationID as ValidationID, 
it.Response as PrimaryValue, it.Response + '!= ''''' as Formula, 'fisdba' as CreatedBy, getdate() as CreatedDate FROM #insertTable it
INNER JOIN [CollectionDev].[dev01].ValidationForm vf
on vf.FormID = it.FormID
and vf.QuestionCode = it.QuestionCode

drop table #holderTable
drop table #insertTable
