USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FX_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FX_Delete]
GO

CREATE PROCEDURE DBO.[FX_Delete]
		@EventID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FX_hst (
			EventID, InstrumentID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EventID, InstrumentID, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FX
	WHERE	EventID = @EventID

	DELETE	FX
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion
GO
