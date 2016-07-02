USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[OfficialNetAssetValue_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[OfficialNetAssetValue_Update]
GO

CREATE PROCEDURE DBO.[OfficialNetAssetValue_Update]
		@OfficialNetAssetValueId int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@InSpecieTransfer numeric(27,8), 
		@UnitsInIssue numeric(27,8), 
		@GrossAssetValue numeric(27,8), 
		@TodayManagementFee numeric(27,8), 
		@ValueIsForReferenceDate bit, 
		@OpeningGAV numeric(27,8), 
		@PercentageOfFund numeric(27,8), 
		@TodayOfficialManagementFee numeric(27,8), 
		@TodayOfficialPerformanceFee numeric(27,8), 
		@TotalOfficialPerformanceFee numeric(27,8), 
		@TodayOfficialPNL numeric(27,8), 
		@TodayOfficialShareClassHedgingPNL numeric(27,8), 
		@NetAssetValueFundCurrency numeric(27,8), 
		@GrossAssetValueFundCurrency numeric(27,8), 
		@TodayOfficialManagementFeeFundCurrency numeric(27,8), 
		@TodayOfficialPerformanceFeeFundCurrency numeric(27,8), 
		@TotalOfficialPerformanceFeeFundCurrency numeric(27,8), 
		@TodayOfficialPNLFundCurrency numeric(27,8), 
		@TodayOfficialShareClassHedgingPNLFundCurrency numeric(27,8), 
		@Subscriptions numeric(27,8), 
		@Redemptions numeric(27,8), 
		@SubscriptionsFundCurrency numeric(27,8), 
		@RedemptionsFundCurrency numeric(27,8), 
		@OpeningGAVFundCurrency numeric(27,8), 
		@OpeningNAVFundCurrency numeric(27,8), 
		@OpeningNAV numeric(27,8), 
		@BifurcatedCurrencyGainLoss numeric(27,8), 
		@FXRateToBase numeric(27,8), 
		@TotalOfficialManagementFee numeric(27,8), 
		@TotalOfficialManagementFeeFundCurrency numeric(27,8), 
		@ShareClassSpecificPNL numeric(27,8), 
		@ToBeLoaded bit, 
		@ShareClassSpecificPNLFundCurrency numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO OfficialNetAssetValue_hst (
			OfficialNetAssetValueId, FundId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, InSpecieTransfer, UnitsInIssue, GrossAssetValue, TodayManagementFee, ValueIsForReferenceDate, OpeningGAV, PercentageOfFund, TodayOfficialManagementFee, TodayOfficialPerformanceFee, TotalOfficialPerformanceFee, TodayOfficialPNL, TodayOfficialShareClassHedgingPNL, NetAssetValueFundCurrency, GrossAssetValueFundCurrency, TodayOfficialManagementFeeFundCurrency, TodayOfficialPerformanceFeeFundCurrency, TotalOfficialPerformanceFeeFundCurrency, TodayOfficialPNLFundCurrency, TodayOfficialShareClassHedgingPNLFundCurrency, Subscriptions, Redemptions, SubscriptionsFundCurrency, RedemptionsFundCurrency, OpeningGAVFundCurrency, OpeningNAVFundCurrency, OpeningNAV, BifurcatedCurrencyGainLoss, FXRateToBase, TotalOfficialManagementFee, TotalOfficialManagementFeeFundCurrency, ShareClassSpecificPNL, ToBeLoaded, ShareClassSpecificPNLFundCurrency, EndDt, LastActionUserID)
	SELECT	OfficialNetAssetValueId, FundId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, InSpecieTransfer, UnitsInIssue, GrossAssetValue, TodayManagementFee, ValueIsForReferenceDate, OpeningGAV, PercentageOfFund, TodayOfficialManagementFee, TodayOfficialPerformanceFee, TotalOfficialPerformanceFee, TodayOfficialPNL, TodayOfficialShareClassHedgingPNL, NetAssetValueFundCurrency, GrossAssetValueFundCurrency, TodayOfficialManagementFeeFundCurrency, TodayOfficialPerformanceFeeFundCurrency, TotalOfficialPerformanceFeeFundCurrency, TodayOfficialPNLFundCurrency, TodayOfficialShareClassHedgingPNLFundCurrency, Subscriptions, Redemptions, SubscriptionsFundCurrency, RedemptionsFundCurrency, OpeningGAVFundCurrency, OpeningNAVFundCurrency, OpeningNAV, BifurcatedCurrencyGainLoss, FXRateToBase, TotalOfficialManagementFee, TotalOfficialManagementFeeFundCurrency, ShareClassSpecificPNL, ToBeLoaded, ShareClassSpecificPNLFundCurrency, @StartDt, @UpdateUserID
	FROM	OfficialNetAssetValue
	WHERE	OfficialNetAssetValueId = @OfficialNetAssetValueId

	UPDATE	OfficialNetAssetValue
	SET		FundId = @FundId, ReferenceDate = @ReferenceDate, Value = @Value, UpdateUserID = @UpdateUserID, InSpecieTransfer = @InSpecieTransfer, UnitsInIssue = @UnitsInIssue, GrossAssetValue = @GrossAssetValue, TodayManagementFee = @TodayManagementFee, ValueIsForReferenceDate = @ValueIsForReferenceDate, OpeningGAV = @OpeningGAV, PercentageOfFund = @PercentageOfFund, TodayOfficialManagementFee = @TodayOfficialManagementFee, TodayOfficialPerformanceFee = @TodayOfficialPerformanceFee, TotalOfficialPerformanceFee = @TotalOfficialPerformanceFee, TodayOfficialPNL = @TodayOfficialPNL, TodayOfficialShareClassHedgingPNL = @TodayOfficialShareClassHedgingPNL, NetAssetValueFundCurrency = @NetAssetValueFundCurrency, GrossAssetValueFundCurrency = @GrossAssetValueFundCurrency, TodayOfficialManagementFeeFundCurrency = @TodayOfficialManagementFeeFundCurrency, TodayOfficialPerformanceFeeFundCurrency = @TodayOfficialPerformanceFeeFundCurrency, TotalOfficialPerformanceFeeFundCurrency = @TotalOfficialPerformanceFeeFundCurrency, TodayOfficialPNLFundCurrency = @TodayOfficialPNLFundCurrency, TodayOfficialShareClassHedgingPNLFundCurrency = @TodayOfficialShareClassHedgingPNLFundCurrency, Subscriptions = @Subscriptions, Redemptions = @Redemptions, SubscriptionsFundCurrency = @SubscriptionsFundCurrency, RedemptionsFundCurrency = @RedemptionsFundCurrency, OpeningGAVFundCurrency = @OpeningGAVFundCurrency, OpeningNAVFundCurrency = @OpeningNAVFundCurrency, OpeningNAV = @OpeningNAV, BifurcatedCurrencyGainLoss = @BifurcatedCurrencyGainLoss, FXRateToBase = @FXRateToBase, TotalOfficialManagementFee = @TotalOfficialManagementFee, TotalOfficialManagementFeeFundCurrency = @TotalOfficialManagementFeeFundCurrency, ShareClassSpecificPNL = @ShareClassSpecificPNL, ToBeLoaded = @ToBeLoaded, ShareClassSpecificPNLFundCurrency = @ShareClassSpecificPNLFundCurrency,  StartDt = @StartDt
	WHERE	OfficialNetAssetValueId = @OfficialNetAssetValueId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	OfficialNetAssetValue
	WHERE	OfficialNetAssetValueId = @OfficialNetAssetValueId
	AND		@@ROWCOUNT > 0

GO
