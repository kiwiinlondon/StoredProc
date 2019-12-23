USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Fund_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Fund_Delete]
GO

CREATE PROCEDURE DBO.[Fund_Delete]
		@LegalEntityID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Fund_hst (
			LegalEntityID, CurrencyID, StartDt, UpdateUserID, DataVersion, PositionsExist, PerfFundName, InstrumentMarketId, BenchmarkInstrumentMarketId, ParentFundId, IsActive, FundTypeId, PriceIsExternallyVisible, InceptionDate, RiskFreeInstrumentMarketId, DealingDateDefinitionId, EZEIdentifier, PortfolioIsExternallyVisible, AssetManagementCompanyId, IntranetOrdering, ReferenceFundId, PerformanceFeeTypeId, LossWarning, LossTrigger, ShareClassDescriptor, PerformanceFee, ManagementFee, AdministratorId, AdministratorIdentifier, IsVoting, ClientLoadDate, IsDistributing, FundStructureId, HasUKReportingStatus, IsClosedToNewInvestors, IsClosedToExistingInvestors, IsStaffOnly, IsIsaEligible, OtherCostRatio, TotalCostRatio, IsSynthetic, ClientMarketingTypeId, IsMainRetailShareClass, PercentageHedged, LockInYears, IsLongOnly, IsMainPerformanceShareClass, IsSolvencyII, IsVAG, TakeOnDate, IsAnalystPnl, CustodianId, ManagerId, ISCFDFullyFunded, IsCRR, EndDt, LastActionUserID)
	SELECT	LegalEntityID, CurrencyID, StartDt, UpdateUserID, DataVersion, PositionsExist, PerfFundName, InstrumentMarketId, BenchmarkInstrumentMarketId, ParentFundId, IsActive, FundTypeId, PriceIsExternallyVisible, InceptionDate, RiskFreeInstrumentMarketId, DealingDateDefinitionId, EZEIdentifier, PortfolioIsExternallyVisible, AssetManagementCompanyId, IntranetOrdering, ReferenceFundId, PerformanceFeeTypeId, LossWarning, LossTrigger, ShareClassDescriptor, PerformanceFee, ManagementFee, AdministratorId, AdministratorIdentifier, IsVoting, ClientLoadDate, IsDistributing, FundStructureId, HasUKReportingStatus, IsClosedToNewInvestors, IsClosedToExistingInvestors, IsStaffOnly, IsIsaEligible, OtherCostRatio, TotalCostRatio, IsSynthetic, ClientMarketingTypeId, IsMainRetailShareClass, PercentageHedged, LockInYears, IsLongOnly, IsMainPerformanceShareClass, IsSolvencyII, IsVAG, TakeOnDate, IsAnalystPnl, CustodianId, ManagerId, ISCFDFullyFunded, IsCRR, @EndDt, @UpdateUserID
	FROM	Fund
	WHERE	LegalEntityID = @LegalEntityID

	DELETE	Fund
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion
GO
