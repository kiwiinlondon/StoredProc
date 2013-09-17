USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientAccount_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientAccount_Update]
GO

CREATE PROCEDURE DBO.[ClientAccount_Update]
		@ClientAccountId int, 
		@ClientId int, 
		@AccountReference varchar(50), 
		@AdministratorId int, 
		@Name varchar(150), 
		@CountryId int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@IsActive bit, 
		@ParentClientAccountId int, 
		@StaffId int, 
		@FundId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientAccount_hst (
			ClientAccountId, ClientId, AccountReference, AdministratorId, Name, CountryId, StartDt, UpdateUserID, DataVersion, IsActive, ParentClientAccountId, StaffId, FundId, EndDt, LastActionUserID)
	SELECT	ClientAccountId, ClientId, AccountReference, AdministratorId, Name, CountryId, StartDt, UpdateUserID, DataVersion, IsActive, ParentClientAccountId, StaffId, FundId, @StartDt, @UpdateUserID
	FROM	ClientAccount
	WHERE	ClientAccountId = @ClientAccountId

	UPDATE	ClientAccount
	SET		ClientId = @ClientId, AccountReference = @AccountReference, AdministratorId = @AdministratorId, Name = @Name, CountryId = @CountryId, UpdateUserID = @UpdateUserID, IsActive = @IsActive, ParentClientAccountId = @ParentClientAccountId, StaffId = @StaffId, FundId = @FundId,  StartDt = @StartDt
	WHERE	ClientAccountId = @ClientAccountId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientAccount
	WHERE	ClientAccountId = @ClientAccountId
	AND		@@ROWCOUNT > 0

GO
