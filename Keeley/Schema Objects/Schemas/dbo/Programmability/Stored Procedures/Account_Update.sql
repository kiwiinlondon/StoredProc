USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Account_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Account_Update]
GO

CREATE PROCEDURE DBO.[Account_Update]
		@AccountID int, 
		@Name varchar(100), 
		@ExternalId varchar(30), 
		@CustodianId int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@FundId int, 
		@AccountTypeId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Account_hst (
			AccountID, Name, ExternalId, CustodianId, StartDt, UpdateUserID, DataVersion, FundId, AccountTypeId, EndDt, LastActionUserID)
	SELECT	AccountID, Name, ExternalId, CustodianId, StartDt, UpdateUserID, DataVersion, FundId, AccountTypeId, @StartDt, @UpdateUserID
	FROM	Account
	WHERE	AccountID = @AccountID

	UPDATE	Account
	SET		Name = @Name, ExternalId = @ExternalId, CustodianId = @CustodianId, UpdateUserID = @UpdateUserID, FundId = @FundId, AccountTypeId = @AccountTypeId,  StartDt = @StartDt
	WHERE	AccountID = @AccountID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Account
	WHERE	AccountID = @AccountID
	AND		@@ROWCOUNT > 0

GO
