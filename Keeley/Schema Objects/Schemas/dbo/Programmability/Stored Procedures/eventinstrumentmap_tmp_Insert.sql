USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[eventinstrumentmap_tmp_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[eventinstrumentmap_tmp_Insert]
GO

CREATE PROCEDURE DBO.[eventinstrumentmap_tmp_Insert]
		@EventID int, 
		@InstrumentID int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into eventinstrumentmap_tmp
			(EventID, InstrumentID, UpdateUserID, StartDt)
	VALUES
			(@EventID, @InstrumentID, @UpdateUserID, @StartDt)

	SELECT	InstrumentID, StartDt, DataVersion
	FROM	eventinstrumentmap_tmp
	WHERE	InstrumentID = @InstrumentID
	AND		@@ROWCOUNT > 0

GO
