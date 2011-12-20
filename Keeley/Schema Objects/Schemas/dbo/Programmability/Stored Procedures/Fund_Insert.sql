USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Fund_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Fund_Insert]
GO

CREATE PROCEDURE DBO.[Fund_Insert]
		@LegalEntityID int, 
		@CurrencyID int, 
		@UpdateUserID int, 
		@PositionsExist bit, 
		@PerfFundName varchar(100), 
		@InstrumentMarketId int, 
		@BenchmarkInstrumentMarketId int, 
		@ParentFundId int, 
		@IsActive bit, 
		@FundTypeId int, 
		@IsExternallyVisible bit, 
		@InceptionDate datetime, 
		@RiskFreeInstrumentMarketId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Fund
			(LegalEntityID, CurrencyID, UpdateUserID, PositionsExist, PerfFundName, InstrumentMarketId, BenchmarkInstrumentMarketId, ParentFundId, IsActive, FundTypeId, IsExternallyVisible, InceptionDate, RiskFreeInstrumentMarketId, StartDt)
	VALUES
			(@LegalEntityID, @CurrencyID, @UpdateUserID, @PositionsExist, @PerfFundName, @InstrumentMarketId, @BenchmarkInstrumentMarketId, @ParentFundId, @IsActive, @FundTypeId, @IsExternallyVisible, @InceptionDate, @RiskFreeInstrumentMarketId, @StartDt)

	SELECT	LegalEntityID, StartDt, DataVersion
	FROM	Fund
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
