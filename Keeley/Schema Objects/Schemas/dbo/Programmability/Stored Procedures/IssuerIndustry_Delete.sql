USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IssuerIndustry_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IssuerIndustry_Delete]
GO

CREATE PROCEDURE DBO.[IssuerIndustry_Delete]
		@IssuerIndustryID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO IssuerIndustry_hst (
			IssuerIndustryID, IssuerID, IndustryID, IndustryClassificationID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	IssuerIndustryID, IssuerID, IndustryID, IndustryClassificationID, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	IssuerIndustry
	WHERE	IssuerIndustryID = @IssuerIndustryID

	DELETE	IssuerIndustry
	WHERE	IssuerIndustryID = @IssuerIndustryID
	AND		DataVersion = @DataVersion
GO
