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
		@AssetManagementCompanyId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO AssetManagementCompany_hst (
			AssetManagementCompanyId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	AssetManagementCompanyId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	AssetManagementCompany
	WHERE	AssetManagementCompanyId = @AssetManagementCompanyId

	DELETE	AssetManagementCompany
	WHERE	AssetManagementCompanyId = @AssetManagementCompanyId
	AND		DataVersion = @DataVersion
GO
