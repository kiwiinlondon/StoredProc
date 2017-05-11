USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Options_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Options_Update]
GO

CREATE PROCEDURE DBO.[Options_Update]
		@InstrumentId int, 
		@IsPut bit, 
		@StrikePrice numeric(27,8), 
		@ExpiryDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Options_hst (
			InstrumentId, IsPut, StrikePrice, ExpiryDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentId, IsPut, StrikePrice, ExpiryDate, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	Options
	WHERE	InstrumentId = @InstrumentId

	UPDATE	Options
	SET		IsPut = @IsPut, StrikePrice = @StrikePrice, ExpiryDate = @ExpiryDate, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	InstrumentId = @InstrumentId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Options
	WHERE	InstrumentId = @InstrumentId
	AND		@@ROWCOUNT > 0

GO
