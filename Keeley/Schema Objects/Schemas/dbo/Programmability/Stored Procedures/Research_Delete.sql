USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Research_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Research_Delete]
GO

CREATE PROCEDURE DBO.[Research_Delete]
		@ResearchId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Research_hst (
			ResearchId, Subject, ContributorId, CodeRedId, Document, StartDt, UpdateUserID, DataVersion, CreatedDt, GicsId, CountryId, AdditionalKeyWords, ActionFlags, IsActioned, IsCRGResearch, EndDt, LastActionUserID)
	SELECT	ResearchId, Subject, ContributorId, CodeRedId, Document, StartDt, UpdateUserID, DataVersion, CreatedDt, GicsId, CountryId, AdditionalKeyWords, ActionFlags, IsActioned, IsCRGResearch, @EndDt, @UpdateUserID
	FROM	Research
	WHERE	ResearchId = @ResearchId

	DELETE	Research
	WHERE	ResearchId = @ResearchId
	AND		DataVersion = @DataVersion
GO
