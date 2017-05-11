USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IndexConstituentOpenClose_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IndexConstituentOpenClose_Update]
GO

CREATE PROCEDURE DBO.[IndexConstituentOpenClose_Update]
		@IndexConstituentOpenCloseId int, 
		@ReferenceDate datetime, 
		@InstrumentMarketId int, 
		@IndexInstrumentId int, 
		@IsOpen bit, 
		@IsClose bit, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO IndexConstituentOpenClose_hst (
			IndexConstituentOpenCloseId, ReferenceDate, InstrumentMarketId, IndexInstrumentId, IsOpen, IsClose, UpdateUserID, DataVersion, StartDt, EndDt, LastActionUserID)
	SELECT	IndexConstituentOpenCloseId, ReferenceDate, InstrumentMarketId, IndexInstrumentId, IsOpen, IsClose, UpdateUserID, DataVersion, StartDt, @StartDt, @UpdateUserID
	FROM	IndexConstituentOpenClose
	WHERE	IndexConstituentOpenCloseId = @IndexConstituentOpenCloseId

	UPDATE	IndexConstituentOpenClose
	SET		ReferenceDate = @ReferenceDate, InstrumentMarketId = @InstrumentMarketId, IndexInstrumentId = @IndexInstrumentId, IsOpen = @IsOpen, IsClose = @IsClose, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	IndexConstituentOpenCloseId = @IndexConstituentOpenCloseId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	IndexConstituentOpenClose
	WHERE	IndexConstituentOpenCloseId = @IndexConstituentOpenCloseId
	AND		@@ROWCOUNT > 0

GO
