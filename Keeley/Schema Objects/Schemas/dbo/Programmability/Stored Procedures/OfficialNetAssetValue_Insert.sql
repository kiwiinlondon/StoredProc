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

	INSERT into OfficialNetAssetValue
			(FundId, ReferenceDate, Value, UpdateUserID, InSpecieTransfer, UnitsInIssue, GrossAssetValue, TodayManagementFee, ValueIsForReferenceDate, OpeningGAV, PercentageOfFund, TodayOfficialManagementFee, TodayOfficialPerformanceFee, TotalOfficialPerformanceFee, TodayOfficialPNL, TodayOfficialShareClassHedgingPNL, NetAssetValueFundCurrency, GrossAssetValueFundCurrency, TodayOfficialManagementFeeFundCurrency, TodayOfficialPerformanceFeeFundCurrency, TotalOfficialPerformanceFeeFundCurrency, TodayOfficialPNLFundCurrency, TodayOfficialShareClassHedgingPNLFundCurrency, Subscriptions, Redemptions, SubscriptionsFundCurrency, RedemptionsFundCurrency, OpeningGAVFundCurrency, OpeningNAVFundCurrency, OpeningNAV, StartDt)
	VALUES
			(@FundId, @ReferenceDate, @Value, @UpdateUserID, @InSpecieTransfer, @UnitsInIssue, @GrossAssetValue, @TodayManagementFee, @ValueIsForReferenceDate, @OpeningGAV, @PercentageOfFund, @TodayOfficialManagementFee, @TodayOfficialPerformanceFee, @TotalOfficialPerformanceFee, @TodayOfficialPNL, @TodayOfficialShareClassHedgingPNL, @NetAssetValueFundCurrency, @GrossAssetValueFundCurrency, @TodayOfficialManagementFeeFundCurrency, @TodayOfficialPerformanceFeeFundCurrency, @TotalOfficialPerformanceFeeFundCurrency, @TodayOfficialPNLFundCurrency, @TodayOfficialShareClassHedgingPNLFundCurrency, @Subscriptions, @Redemptions, @SubscriptionsFundCurrency, @RedemptionsFundCurrency, @OpeningGAVFundCurrency, @OpeningNAVFundCurrency, @OpeningNAV, @StartDt)

	SELECT	OfficialNetAssetValueId, StartDt, DataVersion
	FROM	OfficialNetAssetValue
	WHERE	OfficialNetAssetValueId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
