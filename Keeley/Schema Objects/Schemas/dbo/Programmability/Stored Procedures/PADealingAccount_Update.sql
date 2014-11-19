USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PADealingAccount_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PADealingAccount_Update]
GO

CREATE PROCEDURE DBO.[PADealingAccount_Update]
		@PADealingAccountID int, 
		@Name varchar(100), 
		@Identifier varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@PADealingAccountUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PADealingAccount_hst (
			PADealingAccountID, Name, Identifier, StartDt, UpdateUserID, DataVersion, PADealingAccountUserID, EndDt, LastActionUserID)
	SELECT	PADealingAccountID, Name, Identifier, StartDt, UpdateUserID, DataVersion, PADealingAccountUserID, @StartDt, @UpdateUserID
	FROM	PADealingAccount
	WHERE	PADealingAccountID = @PADealingAccountID

	UPDATE	PADealingAccount
	SET		Name = @Name, Identifier = @Identifier, UpdateUserID = @UpdateUserID, PADealingAccountUserID = @PADealingAccountUserID,  StartDt = @StartDt
	WHERE	PADealingAccountID = @PADealingAccountID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PADealingAccount
	WHERE	PADealingAccountID = @PADealingAccountID
	AND		@@ROWCOUNT > 0

GO
