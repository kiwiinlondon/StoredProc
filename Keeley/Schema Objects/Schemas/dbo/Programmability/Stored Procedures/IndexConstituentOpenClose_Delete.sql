USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IndexConstituentOpenClose_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IndexConstituentOpenClose_Delete]
GO

CREATE PROCEDURE DBO.[IndexConstituentOpenClose_Delete]
		@IndexConstituentOpenCloseId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO IndexConstituentOpenClose_hst (
			IndexConstituentOpenCloseId, ReferenceDate, InstrumentMarketId, IndexInstrumentId, IsOpen, IsClose, UpdateUserID, DataVersion, StartDt, EndDt, LastActionUserID)
	SELECT	IndexConstituentOpenCloseId, ReferenceDate, InstrumentMarketId, IndexInstrumentId, IsOpen, IsClose, UpdateUserID, DataVersion, StartDt, @EndDt, @UpdateUserID
	FROM	IndexConstituentOpenClose
	WHERE	IndexConstituentOpenCloseId = @IndexConstituentOpenCloseId

	DELETE	IndexConstituentOpenClose
	WHERE	IndexConstituentOpenCloseId = @IndexConstituentOpenCloseId
	AND		DataVersion = @DataVersion
GO
