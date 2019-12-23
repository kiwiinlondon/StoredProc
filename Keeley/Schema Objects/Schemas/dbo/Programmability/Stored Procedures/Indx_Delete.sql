USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Indx_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Indx_Delete]
GO

CREATE PROCEDURE DBO.[Indx_Delete]
		@InstrumentMarketId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Indx_hst (
			InstrumentMarketId, StartDt, UpdateUserID, DataVersion, IndexTypeId, CollectWeights, ConstituentsExist, EndDt, LastActionUserID)
	SELECT	InstrumentMarketId, StartDt, UpdateUserID, DataVersion, IndexTypeId, CollectWeights, ConstituentsExist, @EndDt, @UpdateUserID
	FROM	Indx
	WHERE	InstrumentMarketId = @InstrumentMarketId

	DELETE	Indx
	WHERE	InstrumentMarketId = @InstrumentMarketId
	AND		DataVersion = @DataVersion
GO
