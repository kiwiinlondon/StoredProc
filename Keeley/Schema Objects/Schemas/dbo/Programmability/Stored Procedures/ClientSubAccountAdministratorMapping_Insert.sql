USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientSubAccountAdministratorMapping_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientSubAccountAdministratorMapping_Insert]
GO

CREATE PROCEDURE DBO.[ClientSubAccountAdministratorMapping_Insert]
		@SubAccountAdministratorId int, 
		@FundAdministratorId int, 
		@ParentClientId int, 
		@UpdateUserID int, 
		@MappingCodes varchar(500)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientSubAccountAdministratorMapping
			(SubAccountAdministratorId, FundAdministratorId, ParentClientId, UpdateUserID, MappingCodes, StartDt)
	VALUES
			(@SubAccountAdministratorId, @FundAdministratorId, @ParentClientId, @UpdateUserID, @MappingCodes, @StartDt)

	SELECT	SubAccountAdministratorMappingId, StartDt, DataVersion
	FROM	ClientSubAccountAdministratorMapping
	WHERE	SubAccountAdministratorMappingId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
