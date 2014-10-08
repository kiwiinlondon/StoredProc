USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AssetManagementCompany_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AssetManagementCompany_Delete]
GO

CREATE PROCEDURE DBO.[AssetManagementCompany_Delete]
		@LegalEntityID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO AssetManagementCompany_hst (
			StartDt, UpdateUserID, DataVersion, LegalEntityID, EndDt, LastActionUserID)
	SELECT	StartDt, UpdateUserID, DataVersion, LegalEntityID, @EndDt, @UpdateUserID
	FROM	AssetManagementCompany
	WHERE	LegalEntityID = @LegalEntityID

	DELETE	AssetManagementCompany
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion
GO
