USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CollectiveInvestmentScheme_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CollectiveInvestmentScheme_Delete]
GO

CREATE PROCEDURE DBO.[CollectiveInvestmentScheme_Delete]
		@InstrumentID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO CollectiveInvestmentScheme_hst (
			InstrumentID, DealingFrequencyId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentID, DealingFrequencyId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	CollectiveInvestmentScheme
	WHERE	InstrumentID = @InstrumentID

	DELETE	CollectiveInvestmentScheme
	WHERE	InstrumentID = @InstrumentID
	AND		DataVersion = @DataVersion
GO
