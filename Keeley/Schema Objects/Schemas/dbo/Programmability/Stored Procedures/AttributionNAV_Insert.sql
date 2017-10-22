USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionNav_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionNav_Insert]
GO

CREATE PROCEDURE DBO.[AttributionNav_Insert]
		@FundId int, 
		@ReferenceDate datetime, 
		@AttributionSourceId int, 
		@OpeningNAV numeric(15,2), 
		@NAV numeric(15,2), 
		@UpdateUserID int, 
		@PercentageOfFund numeric(9,8), 
		@KeeleyIsMaster bit, 
		@CurrencyId int, 
		@TodayPNL numeric(15,2)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AttributionNav
			(FundId, ReferenceDate, AttributionSourceId, OpeningNAV, NAV, UpdateUserID, PercentageOfFund, KeeleyIsMaster, CurrencyId, TodayPNL, StartDt)
	VALUES
			(@FundId, @ReferenceDate, @AttributionSourceId, @OpeningNAV, @NAV, @UpdateUserID, @PercentageOfFund, @KeeleyIsMaster, @CurrencyId, @TodayPNL, @StartDt)

	SELECT	AttributionNavId, StartDt, DataVersion
	FROM	AttributionNav
	WHERE	AttributionNavId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
