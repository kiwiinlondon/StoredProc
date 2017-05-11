USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Indx_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Indx_Update]
GO

CREATE PROCEDURE DBO.[Indx_Update]
		@InstrumentMarketId int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@IndexTypeId int, 
		@CollectWeights bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Indx_hst (
			InstrumentMarketId, StartDt, UpdateUserID, DataVersion, IndexTypeId, CollectWeights, EndDt, LastActionUserID)
	SELECT	InstrumentMarketId, StartDt, UpdateUserID, DataVersion, IndexTypeId, CollectWeights, @StartDt, @UpdateUserID
	FROM	Indx
	WHERE	InstrumentMarketId = @InstrumentMarketId

	UPDATE	Indx
	SET		UpdateUserID = @UpdateUserID, IndexTypeId = @IndexTypeId, CollectWeights = @CollectWeights,  StartDt = @StartDt
	WHERE	InstrumentMarketId = @InstrumentMarketId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Indx
	WHERE	InstrumentMarketId = @InstrumentMarketId
	AND		@@ROWCOUNT > 0

GO
