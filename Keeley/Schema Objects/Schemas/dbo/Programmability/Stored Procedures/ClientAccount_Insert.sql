USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientAccount_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientAccount_Insert]
GO

CREATE PROCEDURE DBO.[ClientAccount_Insert]
		@ClientId int, 
		@AccountReference varchar(50), 
		@AdministratorId int, 
		@Name varchar(150), 
		@CountryId int, 
		@UpdateUserID int, 
		@IsActive bit, 
		@ParentClientAccountId int, 
		@StaffId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientAccount
			(ClientId, AccountReference, AdministratorId, Name, CountryId, UpdateUserID, IsActive, ParentClientAccountId, StaffId, StartDt)
	VALUES
			(@ClientId, @AccountReference, @AdministratorId, @Name, @CountryId, @UpdateUserID, @IsActive, @ParentClientAccountId, @StaffId, @StartDt)

	SELECT	ClientAccountId, StartDt, DataVersion
	FROM	ClientAccount
	WHERE	ClientAccountId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
