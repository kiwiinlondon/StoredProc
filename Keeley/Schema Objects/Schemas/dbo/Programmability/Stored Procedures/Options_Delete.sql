USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Options_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Options_Delete]
GO

CREATE PROCEDURE DBO.[Options_Delete]
		@InstrumentId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Options_hst (
			InstrumentId, IsPut, StrikePrice, ExpiryDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentId, IsPut, StrikePrice, ExpiryDate, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Options
	WHERE	InstrumentId = @InstrumentId

	DELETE	Options
	WHERE	InstrumentId = @InstrumentId
	AND		DataVersion = @DataVersion
GO
