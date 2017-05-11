USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IndexConstituentOpenClose_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IndexConstituentOpenClose_Insert]
GO

CREATE PROCEDURE DBO.[IndexConstituentOpenClose_Insert]
		@ReferenceDate datetime, 
		@InstrumentMarketId int, 
		@IndexInstrumentId int, 
		@IsOpen bit, 
		@IsClose bit, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into IndexConstituentOpenClose
			(ReferenceDate, InstrumentMarketId, IndexInstrumentId, IsOpen, IsClose, UpdateUserID, StartDt)
	VALUES
			(@ReferenceDate, @InstrumentMarketId, @IndexInstrumentId, @IsOpen, @IsClose, @UpdateUserID, @StartDt)

	SELECT	IndexConstituentOpenCloseId, StartDt, DataVersion
	FROM	IndexConstituentOpenClose
	WHERE	IndexConstituentOpenCloseId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
