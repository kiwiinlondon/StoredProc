USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Future_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Future_Update]
GO

CREATE PROCEDURE DBO.[Future_Update]
		@InstrumentId int, 
		@MaturityDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@ContractSize decimal
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Future_hst (
			InstrumentId, MaturityDate, StartDt, UpdateUserID, DataVersion, ContractSize, EndDt, LastActionUserID)
	SELECT	InstrumentId, MaturityDate, StartDt, UpdateUserID, DataVersion, ContractSize, @StartDt, @UpdateUserID
	FROM	Future
	WHERE	InstrumentId = @InstrumentId

	UPDATE	Future
	SET		MaturityDate = @MaturityDate, UpdateUserID = @UpdateUserID, ContractSize = @ContractSize,  StartDt = @StartDt
	WHERE	InstrumentId = @InstrumentId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Future
	WHERE	InstrumentId = @InstrumentId
	AND		@@ROWCOUNT > 0

GO
