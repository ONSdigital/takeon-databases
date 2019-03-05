INSERT INTO [collectiondev].[dev01].[Response] 
SELECT * FROM (SELECT [collectiondev].[dev01].[Contributor].[Reference], [collectiondev].[dev01].[Contributor].[Period], 
[collectiondev].[dev01].[Contributor].[Survey], [collectiondev].[dev01].[Formdefinition].[QuestionCode], 0 instance,
QuestionCode response, '' createdBy,'' createdDate,'' lastUpdated,'' lastUpdatedBy
FROM [collectiondev].[dev01].[Contributor]
INNER JOIN [collectiondev].[dev01].[FormDefinition] ON 
[collectiondev].[dev01].[FormDefinition].[FormId] = [collectiondev].[dev01].[Contributor].[FormID]) 
AS joined
