USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FX_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FX_Insert]
GO

CREATE PROCEDURE DBO.[FX_Insert]
		@EventID int, 
		@InstrumentID int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FX
			(EventID, InstrumentID, UpdateUserID, StartDt)
	VALUES
			(@EventID, @InstrumentID, @UpdateUserID, @StartDt)

	SELECT	EventID, StartDt, DataVersion
	FROM	FX
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
