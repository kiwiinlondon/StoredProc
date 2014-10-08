USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AssetManagementCompany_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AssetManagementCompany_Update]
GO

CREATE PROCEDURE DBO.[AssetManagementCompany_Update]
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@LegalEntityID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AssetManagementCompany_hst (
			StartDt, UpdateUserID, DataVersion, LegalEntityID, EndDt, LastActionUserID)
	SELECT	StartDt, UpdateUserID, DataVersion, LegalEntityID, @StartDt, @UpdateUserID
	FROM	AssetManagementCompany
	WHERE	LegalEntityID = @LegalEntityID

	UPDATE	AssetManagementCompany
	SET		UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AssetManagementCompany
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
