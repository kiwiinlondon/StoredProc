USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Options_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Options_Insert]
GO

CREATE PROCEDURE DBO.[Options_Insert]
		@InstrumentId int, 
		@IsPut bit, 
		@StrikePrice numeric(27,8), 
		@ExpiryDate datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Options
			(InstrumentId, IsPut, StrikePrice, ExpiryDate, UpdateUserID, StartDt)
	VALUES
			(@InstrumentId, @IsPut, @StrikePrice, @ExpiryDate, @UpdateUserID, @StartDt)

	SELECT	InstrumentId, StartDt, DataVersion
	FROM	Options
	WHERE	InstrumentId = @InstrumentId
	AND		@@ROWCOUNT > 0

GO
