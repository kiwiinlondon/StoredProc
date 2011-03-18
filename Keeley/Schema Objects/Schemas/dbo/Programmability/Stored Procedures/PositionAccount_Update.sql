USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionAccount_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionAccount_Update]
GO

CREATE PROCEDURE DBO.[PositionAccount_Update]
		@PositionAccountID int, 
		@AccountID int, 
		@PositionId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PositionAccount_hst (
			PositionAccountID, AccountID, PositionId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PositionAccountID, AccountID, PositionId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PositionAccount
	WHERE	PositionAccountID = @PositionAccountID

	UPDATE	PositionAccount
	SET		AccountID = @AccountID, PositionId = @PositionId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PositionAccountID = @PositionAccountID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PositionAccount
	WHERE	PositionAccountID = @PositionAccountID
	AND		@@ROWCOUNT > 0

GO
