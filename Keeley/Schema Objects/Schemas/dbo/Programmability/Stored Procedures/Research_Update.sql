USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Research_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Research_Update]
GO

CREATE PROCEDURE DBO.[Research_Update]
		@ResearchId int, 
		@Subject varchar(2000), 
		@ContributorId int, 
		@CodeRedId uniqueidentifier, 
		@Document varbinary(MAX), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@CreatedDt datetime, 
		@GicsId int, 
		@CountryId int, 
		@AdditionalKeyWords varchar(400), 
		@ActionFlags int, 
		@IsActioned bit, 
		@IsCRGResearch bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Research_hst (
			ResearchId, Subject, ContributorId, CodeRedId, Document, StartDt, UpdateUserID, DataVersion, CreatedDt, GicsId, CountryId, AdditionalKeyWords, ActionFlags, IsActioned, IsCRGResearch, EndDt, LastActionUserID)
	SELECT	ResearchId, Subject, ContributorId, CodeRedId, Document, StartDt, UpdateUserID, DataVersion, CreatedDt, GicsId, CountryId, AdditionalKeyWords, ActionFlags, IsActioned, IsCRGResearch, @StartDt, @UpdateUserID
	FROM	Research
	WHERE	ResearchId = @ResearchId

	UPDATE	Research
	SET		Subject = @Subject, ContributorId = @ContributorId, CodeRedId = @CodeRedId, Document = @Document, UpdateUserID = @UpdateUserID, CreatedDt = @CreatedDt, GicsId = @GicsId, CountryId = @CountryId, AdditionalKeyWords = @AdditionalKeyWords, ActionFlags = @ActionFlags, IsActioned = @IsActioned, IsCRGResearch = @IsCRGResearch,  StartDt = @StartDt
	WHERE	ResearchId = @ResearchId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Research
	WHERE	ResearchId = @ResearchId
	AND		@@ROWCOUNT > 0

GO
