USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FMContractMapping_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FMContractMapping_Update]
GO

CREATE PROCEDURE DBO.[FMContractMapping_Update]
		@FMContId int, 
		@InstrumentID int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FMContractMapping_hst (
			FMContId, InstrumentID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FMContId, InstrumentID, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FMContractMapping
	WHERE	FMContId = @FMContId

	UPDATE	FMContractMapping
	SET		InstrumentID = @InstrumentID, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FMContId = @FMContId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FMContractMapping
	WHERE	FMContId = @FMContId
	AND		@@ROWCOUNT > 0

GO
