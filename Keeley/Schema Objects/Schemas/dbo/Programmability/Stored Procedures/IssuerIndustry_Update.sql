USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IssuerIndustry_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IssuerIndustry_Update]
GO

CREATE PROCEDURE DBO.[IssuerIndustry_Update]
		@IssuerIndustryID int, 
		@IssuerID int, 
		@IndustryID int, 
		@IndustryClassificationID int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO IssuerIndustry_hst (
			IssuerIndustryID, IssuerID, IndustryID, IndustryClassificationID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	IssuerIndustryID, IssuerID, IndustryID, IndustryClassificationID, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	IssuerIndustry
	WHERE	IssuerIndustryID = @IssuerIndustryID

	UPDATE	IssuerIndustry
	SET		IssuerID = @IssuerID, IndustryID = @IndustryID, IndustryClassificationID = @IndustryClassificationID, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	IssuerIndustryID = @IssuerIndustryID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	IssuerIndustry
	WHERE	IssuerIndustryID = @IssuerIndustryID
	AND		@@ROWCOUNT > 0

GO
