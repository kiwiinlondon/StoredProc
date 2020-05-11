USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientSubAccountAdministratorMapping_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientSubAccountAdministratorMapping_Update]
GO

CREATE PROCEDURE DBO.[ClientSubAccountAdministratorMapping_Update]
		@SubAccountAdministratorMappingId int, 
		@SubAccountAdministratorId int, 
		@FundAdministratorId int, 
		@ParentClientId int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@MappingCodes varchar(500), 
		@AssetManagementCompanyId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientSubAccountAdministratorMapping_hst (
			SubAccountAdministratorMappingId, SubAccountAdministratorId, FundAdministratorId, ParentClientId, StartDt, UpdateUserID, DataVersion, MappingCodes, AssetManagementCompanyId, EndDt, LastActionUserID)
	SELECT	SubAccountAdministratorMappingId, SubAccountAdministratorId, FundAdministratorId, ParentClientId, StartDt, UpdateUserID, DataVersion, MappingCodes, AssetManagementCompanyId, @StartDt, @UpdateUserID
	FROM	ClientSubAccountAdministratorMapping
	WHERE	SubAccountAdministratorMappingId = @SubAccountAdministratorMappingId

	UPDATE	ClientSubAccountAdministratorMapping
	SET		SubAccountAdministratorId = @SubAccountAdministratorId, FundAdministratorId = @FundAdministratorId, ParentClientId = @ParentClientId, UpdateUserID = @UpdateUserID, MappingCodes = @MappingCodes, AssetManagementCompanyId = @AssetManagementCompanyId,  StartDt = @StartDt
	WHERE	SubAccountAdministratorMappingId = @SubAccountAdministratorMappingId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientSubAccountAdministratorMapping
	WHERE	SubAccountAdministratorMappingId = @SubAccountAdministratorMappingId
	AND		@@ROWCOUNT > 0

GO
