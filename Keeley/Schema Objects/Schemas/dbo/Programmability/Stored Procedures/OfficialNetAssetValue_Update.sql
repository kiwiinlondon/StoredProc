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
		@OpeningGAV numeric(27,8) = null, 
		@PercentageOfFund numeric(27,8) = null, 
		@TodayOfficialManagementFee numeric(27,8) = null, 
		@TodayOfficialPerformanceFee numeric(27,8) = null, 
		@TotalOfficialPerformanceFee numeric(27,8) = null, 
		@TodayOfficialPNL numeric(27,8) = null, 
		@TodayOfficialShareClassHedgingPNL numeric(27,8) = null, 
		@NetAssetValueFundCurrency numeric(27,8) = null, 
		@GrossAssetValueFundCurrency numeric(27,8) = null, 
		@TodayOfficialManagementFeeFundCurrency numeric(27,8) = null, 
		@TodayOfficialPerformanceFeeFundCurrency numeric(27,8) = null, 
		@TotalOfficialPerformanceFeeFundCurrency numeric(27,8) = null, 
		@TodayOfficialPNLFundCurrency numeric(27,8) = null, 
		@TodayOfficialShareClassHedgingPNLFundCurrency numeric(27,8) = null, 
		@Subscriptions numeric(27,8) = null, 
		@Redemptions numeric(27,8) = null, 
		@SubscriptionsFundCurrency numeric(27,8) = null, 
		@RedemptionsFundCurrency numeric(27,8) = null, 
		@OpeningGAVFundCurrency numeric(27,8) = null, 
		@OpeningNAVFundCurrency numeric(27,8) = null, 
		@OpeningNAV numeric(27,8) = null
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO OfficialNetAssetValue_hst (
			OfficialNetAssetValueId, FundId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, InSpecieTransfer, UnitsInIssue, GrossAssetValue, TodayManagementFee, ValueIsForReferenceDate, OpeningGAV, PercentageOfFund, TodayOfficialManagementFee, TodayOfficialPerformanceFee, TotalOfficialPerformanceFee, TodayOfficialPNL, TodayOfficialShareClassHedgingPNL, NetAssetValueFundCurrency, GrossAssetValueFundCurrency, TodayOfficialManagementFeeFundCurrency, TodayOfficialPerformanceFeeFundCurrency, TotalOfficialPerformanceFeeFundCurrency, TodayOfficialPNLFundCurrency, TodayOfficialShareClassHedgingPNLFundCurrency, Subscriptions, Redemptions, SubscriptionsFundCurrency, RedemptionsFundCurrency, OpeningGAVFundCurrency, OpeningNAVFundCurrency, OpeningNAV, EndDt, LastActionUserID)
	SELECT	OfficialNetAssetValueId, FundId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, InSpecieTransfer, UnitsInIssue, GrossAssetValue, TodayManagementFee, ValueIsForReferenceDate, OpeningGAV, PercentageOfFund, TodayOfficialManagementFee, TodayOfficialPerformanceFee, TotalOfficialPerformanceFee, TodayOfficialPNL, TodayOfficialShareClassHedgingPNL, NetAssetValueFundCurrency, GrossAssetValueFundCurrency, TodayOfficialManagementFeeFundCurrency, TodayOfficialPerformanceFeeFundCurrency, TotalOfficialPerformanceFeeFundCurrency, TodayOfficialPNLFundCurrency, TodayOfficialShareClassHedgingPNLFundCurrency, Subscriptions, Redemptions, SubscriptionsFundCurrency, RedemptionsFundCurrency, OpeningGAVFundCurrency, OpeningNAVFundCurrency, OpeningNAV, @StartDt, @UpdateUserID
	FROM	OfficialNetAssetValue
	WHERE	OfficialNetAssetValueId = @OfficialNetAssetValueId

	UPDATE	OfficialNetAssetValue
	SET		FundId = @FundId, ReferenceDate = @ReferenceDate, Value = @Value, UpdateUserID = @UpdateUserID, InSpecieTransfer = @InSpecieTransfer, UnitsInIssue = @UnitsInIssue, GrossAssetValue = @GrossAssetValue, TodayManagementFee = @TodayManagementFee, ValueIsForReferenceDate = @ValueIsForReferenceDate, OpeningGAV = @OpeningGAV, PercentageOfFund = @PercentageOfFund, TodayOfficialManagementFee = @TodayOfficialManagementFee, TodayOfficialPerformanceFee = @TodayOfficialPerformanceFee, TotalOfficialPerformanceFee = @TotalOfficialPerformanceFee, TodayOfficialPNL = @TodayOfficialPNL, TodayOfficialShareClassHedgingPNL = @TodayOfficialShareClassHedgingPNL, NetAssetValueFundCurrency = @NetAssetValueFundCurrency, GrossAssetValueFundCurrency = @GrossAssetValueFundCurrency, TodayOfficialManagementFeeFundCurrency = @TodayOfficialManagementFeeFundCurrency, TodayOfficialPerformanceFeeFundCurrency = @TodayOfficialPerformanceFeeFundCurrency, TotalOfficialPerformanceFeeFundCurrency = @TotalOfficialPerformanceFeeFundCurrency, TodayOfficialPNLFundCurrency = @TodayOfficialPNLFundCurrency, TodayOfficialShareClassHedgingPNLFundCurrency = @TodayOfficialShareClassHedgingPNLFundCurrency, Subscriptions = @Subscriptions, Redemptions = @Redemptions, SubscriptionsFundCurrency = @SubscriptionsFundCurrency, RedemptionsFundCurrency = @RedemptionsFundCurrency, OpeningGAVFundCurrency = @OpeningGAVFundCurrency, OpeningNAVFundCurrency = @OpeningNAVFundCurrency, OpeningNAV = @OpeningNAV,  StartDt = @StartDt
	WHERE	OfficialNetAssetValueId = @OfficialNetAssetValueId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	OfficialNetAssetValue
	WHERE	OfficialNetAssetValueId = @OfficialNetAssetValueId
	AND		@@ROWCOUNT > 0

GO
