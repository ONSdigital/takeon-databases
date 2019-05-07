\c collectiondev;
SET search_path TO dev01,public;

INSERT INTO dev01.Response
SELECT * FROM (SELECT Contributor.Reference, Contributor.Period,
Contributor.Survey, Formdefinition.QuestionCode, 0 instance,
Formdefinition.QuestionCode, 'takeonadmin',CURRENT_TIMESTAMP,'', CURRENT_TIMESTAMP
FROM dev01.Contributor
INNER JOIN dev01.FormDefinition ON
dev01.FormDefinition.FormId = dev01.Contributor.FormID)
AS joined
