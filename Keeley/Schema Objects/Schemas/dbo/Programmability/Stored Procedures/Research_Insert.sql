USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Research_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Research_Insert]
GO

CREATE PROCEDURE DBO.[Research_Insert]
		@Subject varchar(2000), 
		@ContributorId int, 
		@CodeRedId uniqueidentifier, 
		@Document varbinary(MAX), 
		@UpdateUserID int, 
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

	INSERT into Research
			(Subject, ContributorId, CodeRedId, Document, UpdateUserID, CreatedDt, GicsId, CountryId, AdditionalKeyWords, ActionFlags, IsActioned, IsCRGResearch, StartDt)
	VALUES
			(@Subject, @ContributorId, @CodeRedId, @Document, @UpdateUserID, @CreatedDt, @GicsId, @CountryId, @AdditionalKeyWords, @ActionFlags, @IsActioned, @IsCRGResearch, @StartDt)

	SELECT	ResearchId, StartDt, DataVersion
	FROM	Research
	WHERE	ResearchId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
