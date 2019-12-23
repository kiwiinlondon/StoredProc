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
		@IsCRR bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Fund_hst (
			LegalEntityID, CurrencyID, StartDt, UpdateUserID, DataVersion, PositionsExist, PerfFundName, InstrumentMarketId, BenchmarkInstrumentMarketId, ParentFundId, IsActive, FundTypeId, PriceIsExternallyVisible, InceptionDate, RiskFreeInstrumentMarketId, DealingDateDefinitionId, EZEIdentifier, PortfolioIsExternallyVisible, AssetManagementCompanyId, IntranetOrdering, ReferenceFundId, PerformanceFeeTypeId, LossWarning, LossTrigger, ShareClassDescriptor, PerformanceFee, ManagementFee, AdministratorId, AdministratorIdentifier, IsVoting, ClientLoadDate, IsDistributing, FundStructureId, HasUKReportingStatus, IsClosedToNewInvestors, IsClosedToExistingInvestors, IsStaffOnly, IsIsaEligible, OtherCostRatio, TotalCostRatio, IsSynthetic, ClientMarketingTypeId, IsMainRetailShareClass, PercentageHedged, LockInYears, IsLongOnly, IsMainPerformanceShareClass, IsSolvencyII, IsVAG, TakeOnDate, IsAnalystPnl, CustodianId, ManagerId, ISCFDFullyFunded, IsCRR, EndDt, LastActionUserID)
	SELECT	LegalEntityID, CurrencyID, StartDt, UpdateUserID, DataVersion, PositionsExist, PerfFundName, InstrumentMarketId, BenchmarkInstrumentMarketId, ParentFundId, IsActive, FundTypeId, PriceIsExternallyVisible, InceptionDate, RiskFreeInstrumentMarketId, DealingDateDefinitionId, EZEIdentifier, PortfolioIsExternallyVisible, AssetManagementCompanyId, IntranetOrdering, ReferenceFundId, PerformanceFeeTypeId, LossWarning, LossTrigger, ShareClassDescriptor, PerformanceFee, ManagementFee, AdministratorId, AdministratorIdentifier, IsVoting, ClientLoadDate, IsDistributing, FundStructureId, HasUKReportingStatus, IsClosedToNewInvestors, IsClosedToExistingInvestors, IsStaffOnly, IsIsaEligible, OtherCostRatio, TotalCostRatio, IsSynthetic, ClientMarketingTypeId, IsMainRetailShareClass, PercentageHedged, LockInYears, IsLongOnly, IsMainPerformanceShareClass, IsSolvencyII, IsVAG, TakeOnDate, IsAnalystPnl, CustodianId, ManagerId, ISCFDFullyFunded, IsCRR, @StartDt, @UpdateUserID
	FROM	Fund
	WHERE	LegalEntityID = @LegalEntityID

	UPDATE	Fund
	SET		CurrencyID = @CurrencyID, UpdateUserID = @UpdateUserID, PositionsExist = @PositionsExist, PerfFundName = @PerfFundName, InstrumentMarketId = @InstrumentMarketId, BenchmarkInstrumentMarketId = @BenchmarkInstrumentMarketId, ParentFundId = @ParentFundId, IsActive = @IsActive, FundTypeId = @FundTypeId, PriceIsExternallyVisible = @PriceIsExternallyVisible, InceptionDate = @InceptionDate, RiskFreeInstrumentMarketId = @RiskFreeInstrumentMarketId, DealingDateDefinitionId = @DealingDateDefinitionId, EZEIdentifier = @EZEIdentifier, PortfolioIsExternallyVisible = @PortfolioIsExternallyVisible, AssetManagementCompanyId = @AssetManagementCompanyId, IntranetOrdering = @IntranetOrdering, ReferenceFundId = @ReferenceFundId, PerformanceFeeTypeId = @PerformanceFeeTypeId, LossWarning = @LossWarning, LossTrigger = @LossTrigger, ShareClassDescriptor = @ShareClassDescriptor, PerformanceFee = @PerformanceFee, ManagementFee = @ManagementFee, AdministratorId = @AdministratorId, AdministratorIdentifier = @AdministratorIdentifier, IsVoting = @IsVoting, ClientLoadDate = @ClientLoadDate, IsDistributing = @IsDistributing, FundStructureId = @FundStructureId, HasUKReportingStatus = @HasUKReportingStatus, IsClosedToNewInvestors = @IsClosedToNewInvestors, IsClosedToExistingInvestors = @IsClosedToExistingInvestors, IsStaffOnly = @IsStaffOnly, IsIsaEligible = @IsIsaEligible, OtherCostRatio = @OtherCostRatio, TotalCostRatio = @TotalCostRatio, IsSynthetic = @IsSynthetic, ClientMarketingTypeId = @ClientMarketingTypeId, IsMainRetailShareClass = @IsMainRetailShareClass, PercentageHedged = @PercentageHedged, LockInYears = @LockInYears, IsLongOnly = @IsLongOnly, IsMainPerformanceShareClass = @IsMainPerformanceShareClass, IsSolvencyII = @IsSolvencyII, IsVAG = @IsVAG, TakeOnDate = @TakeOnDate, IsAnalystPnl = @IsAnalystPnl, CustodianId = @CustodianId, ManagerId = @ManagerId, ISCFDFullyFunded = @ISCFDFullyFunded, IsCRR = @IsCRR,  StartDt = @StartDt
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Fund
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
