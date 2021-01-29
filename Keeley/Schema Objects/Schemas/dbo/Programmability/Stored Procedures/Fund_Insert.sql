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
		@PriceIsExternallyVisible bit, 
		@InceptionDate datetime, 
		@RiskFreeInstrumentMarketId int, 
		@DealingDateDefinitionId int, 
		@EZEIdentifier varchar(100), 
		@PortfolioIsExternallyVisible bit, 
		@AssetManagementCompanyId int, 
		@IntranetOrdering int, 
		@ReferenceFundId int, 
		@PerformanceFeeTypeId int, 
		@LossWarning numeric(27,8), 
		@LossTrigger numeric(27,8), 
		@ShareClassDescriptor varchar(50), 
		@PerformanceFee numeric(27,8), 
		@ManagementFee numeric(27,8), 
		@AdministratorId int, 
		@AdministratorIdentifier varchar(100), 
		@IsVoting bit, 
		@ClientLoadDate datetime, 
		@IsDistributing bit, 
		@FundStructureId int, 
		@HasUKReportingStatus bit, 
		@IsClosedToNewInvestors bit, 
		@IsClosedToExistingInvestors bit, 
		@IsStaffOnly bit, 
		@IsIsaEligible bit, 
		@OtherCostRatio numeric(27,8), 
		@TotalCostRatio numeric(27,8), 
		@IsSynthetic bit, 
		@ClientMarketingTypeId int, 
		@IsMainRetailShareClass bit, 
		@PercentageHedged numeric(27,8), 
		@LockInYears int, 
		@IsLongOnly bit, 
		@IsMainPerformanceShareClass bit, 
		@IsSolvencyII bit, 
		@IsVAG bit, 
		@TakeOnDate datetime, 
		@IsAnalystPnl bit, 
		@CustodianId int, 
		@ManagerId int, 
		@ISCFDFullyFunded bit, 
		@IsCRR bit, 
		@TaxReferenceNumber varchar(100), 
		@FundFeederTypeId int, 
		@FocusRegionId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Fund
			(LegalEntityID, CurrencyID, UpdateUserID, PositionsExist, PerfFundName, InstrumentMarketId, BenchmarkInstrumentMarketId, ParentFundId, IsActive, FundTypeId, PriceIsExternallyVisible, InceptionDate, RiskFreeInstrumentMarketId, DealingDateDefinitionId, EZEIdentifier, PortfolioIsExternallyVisible, AssetManagementCompanyId, IntranetOrdering, ReferenceFundId, PerformanceFeeTypeId, LossWarning, LossTrigger, ShareClassDescriptor, PerformanceFee, ManagementFee, AdministratorId, AdministratorIdentifier, IsVoting, ClientLoadDate, IsDistributing, FundStructureId, HasUKReportingStatus, IsClosedToNewInvestors, IsClosedToExistingInvestors, IsStaffOnly, IsIsaEligible, OtherCostRatio, TotalCostRatio, IsSynthetic, ClientMarketingTypeId, IsMainRetailShareClass, PercentageHedged, LockInYears, IsLongOnly, IsMainPerformanceShareClass, IsSolvencyII, IsVAG, TakeOnDate, IsAnalystPnl, CustodianId, ManagerId, ISCFDFullyFunded, IsCRR, TaxReferenceNumber, FundFeederTypeId, FocusRegionId, StartDt)
	VALUES
			(@LegalEntityID, @CurrencyID, @UpdateUserID, @PositionsExist, @PerfFundName, @InstrumentMarketId, @BenchmarkInstrumentMarketId, @ParentFundId, @IsActive, @FundTypeId, @PriceIsExternallyVisible, @InceptionDate, @RiskFreeInstrumentMarketId, @DealingDateDefinitionId, @EZEIdentifier, @PortfolioIsExternallyVisible, @AssetManagementCompanyId, @IntranetOrdering, @ReferenceFundId, @PerformanceFeeTypeId, @LossWarning, @LossTrigger, @ShareClassDescriptor, @PerformanceFee, @ManagementFee, @AdministratorId, @AdministratorIdentifier, @IsVoting, @ClientLoadDate, @IsDistributing, @FundStructureId, @HasUKReportingStatus, @IsClosedToNewInvestors, @IsClosedToExistingInvestors, @IsStaffOnly, @IsIsaEligible, @OtherCostRatio, @TotalCostRatio, @IsSynthetic, @ClientMarketingTypeId, @IsMainRetailShareClass, @PercentageHedged, @LockInYears, @IsLongOnly, @IsMainPerformanceShareClass, @IsSolvencyII, @IsVAG, @TakeOnDate, @IsAnalystPnl, @CustodianId, @ManagerId, @ISCFDFullyFunded, @IsCRR, @TaxReferenceNumber, @FundFeederTypeId, @FocusRegionId, @StartDt)

	SELECT	LegalEntityID, StartDt, DataVersion
	FROM	Fund
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
