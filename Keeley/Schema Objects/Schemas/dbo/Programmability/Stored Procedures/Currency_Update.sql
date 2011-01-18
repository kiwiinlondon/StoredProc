USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Currency_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Currency_Update]
GO

CREATE PROCEDURE DBO.[Currency_Update]
		@InstrumentID int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Currency_hst (
			InstrumentID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentID, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	Currency
	WHERE	InstrumentID = InstrumentID

	UPDATE	Currency
	SET		UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	InstrumentID = @InstrumentID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Currency
	WHERE	InstrumentID = @InstrumentID
	AND		@@ROWCOUNT > 0

GO
