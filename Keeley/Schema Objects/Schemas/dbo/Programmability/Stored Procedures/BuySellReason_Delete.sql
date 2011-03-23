USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BuySellReason_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BuySellReason_Delete]
GO

CREATE PROCEDURE DBO.[BuySellReason_Delete]
		@BuySellReasonID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO BuySellReason_hst (
			BuySellReasonID, Code, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	BuySellReasonID, Code, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	BuySellReason
	WHERE	BuySellReasonID = @BuySellReasonID

	DELETE	BuySellReason
	WHERE	BuySellReasonID = @BuySellReasonID
	AND		DataVersion = @DataVersion
GO
