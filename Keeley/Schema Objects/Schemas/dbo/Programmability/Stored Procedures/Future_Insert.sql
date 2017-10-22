USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Future_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Future_Insert]
GO

CREATE PROCEDURE DBO.[Future_Insert]
		@InstrumentId int, 
		@MaturityDate datetime, 
		@UpdateUserID int, 
		@ContractSize decimal
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Future
			(InstrumentId, MaturityDate, UpdateUserID, ContractSize, StartDt)
	VALUES
			(@InstrumentId, @MaturityDate, @UpdateUserID, @ContractSize, @StartDt)

	SELECT	InstrumentId, StartDt, DataVersion
	FROM	Future
	WHERE	InstrumentId = @InstrumentId
	AND		@@ROWCOUNT > 0

GO
