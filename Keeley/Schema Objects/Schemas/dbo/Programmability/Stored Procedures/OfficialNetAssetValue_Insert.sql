USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[OfficialNetAssetValue_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[OfficialNetAssetValue_Insert]
GO

CREATE PROCEDURE DBO.[OfficialNetAssetValue_Insert]
		@FundId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
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
		@ShareClassSpecificPNLFundCurrency numeric(27,8), 
		@UncrystallisedPerformanceFeeChange numeric(27,8), 
		@UncrystallisedPerformanceFeeChangeFundCurrency numeric(27,8), 
		@GrossPNL numeric(27,8), 
		@GrossPNLFundCurrency numeric(27,8), 
		@MasterNav numeric(27,8), 
		@FeederNav numeric(27,8), 
		@CalculateAttributionPNL bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into OfficialNetAssetValue
			(FundId, ReferenceDate, Value, UpdateUserID, InSpecieTransfer, UnitsInIssue, GrossAssetValue, TodayManagementFee, ValueIsForReferenceDate, OpeningGAV, PercentageOfFund, TodayOfficialManagementFee, TodayOfficialPerformanceFee, TotalOfficialPerformanceFee, TodayOfficialPNL, TodayOfficialShareClassHedgingPNL, NetAssetValueFundCurrency, GrossAssetValueFundCurrency, TodayOfficialManagementFeeFundCurrency, TodayOfficialPerformanceFeeFundCurrency, TotalOfficialPerformanceFeeFundCurrency, TodayOfficialPNLFundCurrency, TodayOfficialShareClassHedgingPNLFundCurrency, Subscriptions, Redemptions, SubscriptionsFundCurrency, RedemptionsFundCurrency, OpeningGAVFundCurrency, OpeningNAVFundCurrency, OpeningNAV, BifurcatedCurrencyGainLoss, FXRateToBase, TotalOfficialManagementFee, TotalOfficialManagementFeeFundCurrency, ShareClassSpecificPNL, ToBeLoaded, ShareClassSpecificPNLFundCurrency, UncrystallisedPerformanceFeeChange, UncrystallisedPerformanceFeeChangeFundCurrency, GrossPNL, GrossPNLFundCurrency, MasterNav, FeederNav, CalculateAttributionPNL, StartDt)
	VALUES
			(@FundId, @ReferenceDate, @Value, @UpdateUserID, @InSpecieTransfer, @UnitsInIssue, @GrossAssetValue, @TodayManagementFee, @ValueIsForReferenceDate, @OpeningGAV, @PercentageOfFund, @TodayOfficialManagementFee, @TodayOfficialPerformanceFee, @TotalOfficialPerformanceFee, @TodayOfficialPNL, @TodayOfficialShareClassHedgingPNL, @NetAssetValueFundCurrency, @GrossAssetValueFundCurrency, @TodayOfficialManagementFeeFundCurrency, @TodayOfficialPerformanceFeeFundCurrency, @TotalOfficialPerformanceFeeFundCurrency, @TodayOfficialPNLFundCurrency, @TodayOfficialShareClassHedgingPNLFundCurrency, @Subscriptions, @Redemptions, @SubscriptionsFundCurrency, @RedemptionsFundCurrency, @OpeningGAVFundCurrency, @OpeningNAVFundCurrency, @OpeningNAV, @BifurcatedCurrencyGainLoss, @FXRateToBase, @TotalOfficialManagementFee, @TotalOfficialManagementFeeFundCurrency, @ShareClassSpecificPNL, @ToBeLoaded, @ShareClassSpecificPNLFundCurrency, @UncrystallisedPerformanceFeeChange, @UncrystallisedPerformanceFeeChangeFundCurrency, @GrossPNL, @GrossPNLFundCurrency, @MasterNav, @FeederNav, @CalculateAttributionPNL, @StartDt)

	SELECT	OfficialNetAssetValueId, StartDt, DataVersion
	FROM	OfficialNetAssetValue
	WHERE	OfficialNetAssetValueId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
