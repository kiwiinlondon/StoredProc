USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Currency_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Currency_Delete]
GO

CREATE PROCEDURE DBO.[Currency_Delete]
		@InstrumentID timestamp,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Currency_hst (
			InstrumentID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentID, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Currency
	WHERE	InstrumentID = InstrumentID

	DELETE	Currency
	WHERE	InstrumentID = @InstrumentID
	AND		DataVersion = @DataVersion
GO
