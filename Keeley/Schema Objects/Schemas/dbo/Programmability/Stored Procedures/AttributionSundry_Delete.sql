USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionSundry_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionSundry_Delete]
GO

CREATE PROCEDURE DBO.[AttributionSundry_Delete]
		@AttributionSundryId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO AttributionSundry_hst (
			AttributionSundryId, PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, Value, StartDt, UpdateUserID, DataVersion, AttributionNavId, SundryTypeId, PercentageOfFund, CurrencyId, EndDt, LastActionUserID)
	SELECT	AttributionSundryId, PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, Value, StartDt, UpdateUserID, DataVersion, AttributionNavId, SundryTypeId, PercentageOfFund, CurrencyId, @EndDt, @UpdateUserID
	FROM	AttributionSundry
	WHERE	AttributionSundryId = @AttributionSundryId

	DELETE	AttributionSundry
	WHERE	AttributionSundryId = @AttributionSundryId
	AND		DataVersion = @DataVersion
GO
