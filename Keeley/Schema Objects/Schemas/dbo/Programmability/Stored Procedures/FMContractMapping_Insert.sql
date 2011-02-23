USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FMContractMapping_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FMContractMapping_Insert]
GO

CREATE PROCEDURE DBO.[FMContractMapping_Insert]
		@FMContId int, 
		@InstrumentID int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FMContractMapping
			(FMContId, InstrumentID, UpdateUserID, StartDt)
	VALUES
			(@FMContId, @InstrumentID, @UpdateUserID, @StartDt)

	SELECT	FMContId, StartDt, DataVersion
	FROM	FMContractMapping
	WHERE	FMContId = @FMContId
	AND		@@ROWCOUNT > 0

GO
