USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionSundry_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionSundry_Insert]
GO

CREATE PROCEDURE DBO.[AttributionSundry_Insert]
		@PortfolioId int, 
		@FundId int, 
		@PositionID int, 
		@ReferenceDate datetime, 
		@AttributionSourceId int, 
		@Value numeric(15,2), 
		@UpdateUserID int, 
		@AttributionNavId int, 
		@SundryTypeId int, 
		@PercentageOfFund numeric(9,8), 
		@CurrencyId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AttributionSundry
			(PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, Value, UpdateUserID, AttributionNavId, SundryTypeId, PercentageOfFund, CurrencyId, StartDt)
	VALUES
			(@PortfolioId, @FundId, @PositionID, @ReferenceDate, @AttributionSourceId, @Value, @UpdateUserID, @AttributionNavId, @SundryTypeId, @PercentageOfFund, @CurrencyId, @StartDt)

	SELECT	AttributionSundryId, StartDt, DataVersion
	FROM	AttributionSundry
	WHERE	AttributionSundryId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
