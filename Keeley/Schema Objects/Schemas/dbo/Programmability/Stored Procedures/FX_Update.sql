USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FX_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FX_Update]
GO

CREATE PROCEDURE DBO.[FX_Update]
		@EventID int, 
		@InstrumentID int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FX_hst (
			EventID, InstrumentID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EventID, InstrumentID, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FX
	WHERE	EventID = @EventID

	UPDATE	FX
	SET		InstrumentID = @InstrumentID, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FX
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
