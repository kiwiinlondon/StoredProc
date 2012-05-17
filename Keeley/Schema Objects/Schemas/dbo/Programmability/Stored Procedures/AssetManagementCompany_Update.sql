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
		@AssetManagementCompanyId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AssetManagementCompany_hst (
			AssetManagementCompanyId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	AssetManagementCompanyId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	AssetManagementCompany
	WHERE	AssetManagementCompanyId = @AssetManagementCompanyId

	UPDATE	AssetManagementCompany
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	AssetManagementCompanyId = @AssetManagementCompanyId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AssetManagementCompany
	WHERE	AssetManagementCompanyId = @AssetManagementCompanyId
	AND		@@ROWCOUNT > 0

GO
