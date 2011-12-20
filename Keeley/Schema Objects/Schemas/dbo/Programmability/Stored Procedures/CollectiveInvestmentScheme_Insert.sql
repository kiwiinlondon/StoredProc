USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CollectiveInvestmentScheme_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CollectiveInvestmentScheme_Insert]
GO

CREATE PROCEDURE DBO.[CollectiveInvestmentScheme_Insert]
		@InstrumentID int, 
		@DealingFrequencyId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into CollectiveInvestmentScheme
			(InstrumentID, DealingFrequencyId, UpdateUserID, StartDt)
	VALUES
			(@InstrumentID, @DealingFrequencyId, @UpdateUserID, @StartDt)

	SELECT	InstrumentID, StartDt, DataVersion
	FROM	CollectiveInvestmentScheme
	WHERE	InstrumentID = @InstrumentID
	AND		@@ROWCOUNT > 0

GO
