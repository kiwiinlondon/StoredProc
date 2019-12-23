USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BuySellReason_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BuySellReason_Update]
GO

CREATE PROCEDURE DBO.[BuySellReason_Update]
		@BuySellReasonID int, 
		@Code varchar(30), 
		@Name varchar(200), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO BuySellReason_hst (
			BuySellReasonID, Code, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	BuySellReasonID, Code, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	BuySellReason
	WHERE	BuySellReasonID = @BuySellReasonID

	UPDATE	BuySellReason
	SET		Code = @Code, Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	BuySellReasonID = @BuySellReasonID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	BuySellReason
	WHERE	BuySellReasonID = @BuySellReasonID
	AND		@@ROWCOUNT > 0

GO
