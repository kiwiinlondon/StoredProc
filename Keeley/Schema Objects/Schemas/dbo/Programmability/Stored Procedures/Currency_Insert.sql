USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Currency_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Currency_Insert]
GO

CREATE PROCEDURE DBO.[Currency_Insert]
		@InstrumentID int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Currency
			(InstrumentID, UpdateUserID, StartDt)
	VALUES
			(@InstrumentID, @UpdateUserID, @StartDt)

	SELECT	InstrumentID, StartDt, DataVersion
	FROM	Currency
	WHERE	InstrumentID = @InstrumentID
	AND		@@ROWCOUNT > 0

GO
