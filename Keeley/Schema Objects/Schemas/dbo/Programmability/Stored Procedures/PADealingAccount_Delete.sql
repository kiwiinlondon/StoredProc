USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PADealingAccount_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PADealingAccount_Delete]
GO

CREATE PROCEDURE DBO.[PADealingAccount_Delete]
		@PADealingAccountID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PADealingAccount_hst (
			PADealingAccountID, UserID, Name, Number, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PADealingAccountID, UserID, Name, Number, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PADealingAccount
	WHERE	PADealingAccountID = @PADealingAccountID

	DELETE	PADealingAccount
	WHERE	PADealingAccountID = @PADealingAccountID
	AND		DataVersion = @DataVersion
GO
