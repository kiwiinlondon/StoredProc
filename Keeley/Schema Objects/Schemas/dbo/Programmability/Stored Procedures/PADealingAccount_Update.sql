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
		@UserID int, 
		@Name varchar(100), 
		@Number varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@PADealingBrokerId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PADealingAccount_hst (
			PADealingAccountID, UserID, Name, Number, StartDt, UpdateUserID, DataVersion, PADealingBrokerId, EndDt, LastActionUserID)
	SELECT	PADealingAccountID, UserID, Name, Number, StartDt, UpdateUserID, DataVersion, PADealingBrokerId, @StartDt, @UpdateUserID
	FROM	PADealingAccount
	WHERE	PADealingAccountID = @PADealingAccountID

	UPDATE	PADealingAccount
	SET		UserID = @UserID, Name = @Name, Number = @Number, UpdateUserID = @UpdateUserID, PADealingBrokerId = @PADealingBrokerId,  StartDt = @StartDt
	WHERE	PADealingAccountID = @PADealingAccountID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PADealingAccount
	WHERE	PADealingAccountID = @PADealingAccountID
	AND		@@ROWCOUNT > 0

GO
