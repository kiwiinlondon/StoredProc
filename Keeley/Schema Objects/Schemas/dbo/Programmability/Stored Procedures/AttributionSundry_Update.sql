USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionSundry_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionSundry_Update]
GO

CREATE PROCEDURE DBO.[AttributionSundry_Update]
		@AttributionSundryId int, 
		@PortfolioId int, 
		@FundId int, 
		@PositionID int, 
		@ReferenceDate datetime, 
		@AttributionSourceId int, 
		@Value numeric(15,2), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@AttributionNavId int, 
		@SundryTypeId int, 
		@PercentageOfFund numeric(9,8), 
		@CurrencyId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AttributionSundry_hst (
			AttributionSundryId, PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, Value, StartDt, UpdateUserID, DataVersion, AttributionNavId, SundryTypeId, PercentageOfFund, CurrencyId, EndDt, LastActionUserID)
	SELECT	AttributionSundryId, PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, Value, StartDt, UpdateUserID, DataVersion, AttributionNavId, SundryTypeId, PercentageOfFund, CurrencyId, @StartDt, @UpdateUserID
	FROM	AttributionSundry
	WHERE	AttributionSundryId = @AttributionSundryId

	UPDATE	AttributionSundry
	SET		PortfolioId = @PortfolioId, FundId = @FundId, PositionID = @PositionID, ReferenceDate = @ReferenceDate, AttributionSourceId = @AttributionSourceId, Value = @Value, UpdateUserID = @UpdateUserID, AttributionNavId = @AttributionNavId, SundryTypeId = @SundryTypeId, PercentageOfFund = @PercentageOfFund, CurrencyId = @CurrencyId,  StartDt = @StartDt
	WHERE	AttributionSundryId = @AttributionSundryId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AttributionSundry
	WHERE	AttributionSundryId = @AttributionSundryId
	AND		@@ROWCOUNT > 0

GO
