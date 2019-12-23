USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CollectiveInvestmentScheme_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CollectiveInvestmentScheme_Update]
GO

CREATE PROCEDURE DBO.[CollectiveInvestmentScheme_Update]
		@InstrumentID int, 
		@DealingFrequencyId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO CollectiveInvestmentScheme_hst (
			InstrumentID, DealingFrequencyId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentID, DealingFrequencyId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	CollectiveInvestmentScheme
	WHERE	InstrumentID = @InstrumentID

	UPDATE	CollectiveInvestmentScheme
	SET		DealingFrequencyId = @DealingFrequencyId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	InstrumentID = @InstrumentID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	CollectiveInvestmentScheme
	WHERE	InstrumentID = @InstrumentID
	AND		@@ROWCOUNT > 0

GO
