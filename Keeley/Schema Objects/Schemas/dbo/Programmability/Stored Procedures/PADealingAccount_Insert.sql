USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PADealingAccount_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PADealingAccount_Insert]
GO

CREATE PROCEDURE DBO.[PADealingAccount_Insert]
		@UserID int, 
		@Name varchar(100), 
		@Number varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PADealingAccount
			(UserID, Name, Number, UpdateUserID, StartDt)
	VALUES
			(@UserID, @Name, @Number, @UpdateUserID, @StartDt)

	SELECT	PADealingAccountID, StartDt, DataVersion
	FROM	PADealingAccount
	WHERE	PADealingAccountID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
