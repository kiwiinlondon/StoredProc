USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[eventinstrumentmap_tmp_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[eventinstrumentmap_tmp_Update]
GO

CREATE PROCEDURE DBO.[eventinstrumentmap_tmp_Update]
		@EventID int, 
		@InstrumentID int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO eventinstrumentmap_tmp_hst (
			EventID, InstrumentID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EventID, InstrumentID, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	eventinstrumentmap_tmp
	WHERE	InstrumentID = @InstrumentID

	UPDATE	eventinstrumentmap_tmp
	SET		EventID = @EventID, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	InstrumentID = @InstrumentID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	eventinstrumentmap_tmp
	WHERE	InstrumentID = @InstrumentID
	AND		@@ROWCOUNT > 0

GO
