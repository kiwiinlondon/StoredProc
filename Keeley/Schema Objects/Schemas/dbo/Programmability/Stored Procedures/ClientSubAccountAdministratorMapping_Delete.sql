USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientSubAccountAdministratorMapping_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientSubAccountAdministratorMapping_Delete]
GO

CREATE PROCEDURE DBO.[ClientSubAccountAdministratorMapping_Delete]
		@SubAccountAdministratorMappingId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ClientSubAccountAdministratorMapping_hst (
			SubAccountAdministratorMappingId, SubAccountAdministratorId, FundAdministratorId, ParentClientId, StartDt, UpdateUserID, DataVersion, MappingCodes, EndDt, LastActionUserID)
	SELECT	SubAccountAdministratorMappingId, SubAccountAdministratorId, FundAdministratorId, ParentClientId, StartDt, UpdateUserID, DataVersion, MappingCodes, @EndDt, @UpdateUserID
	FROM	ClientSubAccountAdministratorMapping
	WHERE	SubAccountAdministratorMappingId = @SubAccountAdministratorMappingId

	DELETE	ClientSubAccountAdministratorMapping
	WHERE	SubAccountAdministratorMappingId = @SubAccountAdministratorMappingId
	AND		DataVersion = @DataVersion
GO
