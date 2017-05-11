USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Future_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Future_Delete]
GO

CREATE PROCEDURE DBO.[Future_Delete]
		@InstrumentId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Future_hst (
			InstrumentId, MaturityDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentId, MaturityDate, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Future
	WHERE	InstrumentId = @InstrumentId

	DELETE	Future
	WHERE	InstrumentId = @InstrumentId
	AND		DataVersion = @DataVersion
GO
