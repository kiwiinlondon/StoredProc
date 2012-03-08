USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Fund_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Fund_Update]
GO

CREATE PROCEDURE DBO.[Fund_Update]
		@LegalEntityID int, 
		@CurrencyID int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@PositionsExist bit, 
		@PerfFundName varchar(100), 
		@InstrumentMarketId int, 
		@BenchmarkInstrumentMarketId int, 
		@ParentFundId int, 
		@IsActive bit, 
		@FundTypeId int, 
		@IsExternallyVisible bit, 
		@InceptionDate datetime, 
		@RiskFreeInstrumentMarketId int, 
		@DealingDateDefinitionId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Fund_hst (
			LegalEntityID, CurrencyID, StartDt, UpdateUserID, DataVersion, PositionsExist, PerfFundName, InstrumentMarketId, BenchmarkInstrumentMarketId, ParentFundId, IsActive, FundTypeId, IsExternallyVisible, InceptionDate, RiskFreeInstrumentMarketId, DealingDateDefinitionId, EndDt, LastActionUserID)
	SELECT	LegalEntityID, CurrencyID, StartDt, UpdateUserID, DataVersion, PositionsExist, PerfFundName, InstrumentMarketId, BenchmarkInstrumentMarketId, ParentFundId, IsActive, FundTypeId, IsExternallyVisible, InceptionDate, RiskFreeInstrumentMarketId, DealingDateDefinitionId, @StartDt, @UpdateUserID
	FROM	Fund
	WHERE	LegalEntityID = @LegalEntityID

	UPDATE	Fund
	SET		CurrencyID = @CurrencyID, UpdateUserID = @UpdateUserID, PositionsExist = @PositionsExist, PerfFundName = @PerfFundName, InstrumentMarketId = @InstrumentMarketId, BenchmarkInstrumentMarketId = @BenchmarkInstrumentMarketId, ParentFundId = @ParentFundId, IsActive = @IsActive, FundTypeId = @FundTypeId, IsExternallyVisible = @IsExternallyVisible, InceptionDate = @InceptionDate, RiskFreeInstrumentMarketId = @RiskFreeInstrumentMarketId, DealingDateDefinitionId = @DealingDateDefinitionId,  StartDt = @StartDt
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Fund
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
