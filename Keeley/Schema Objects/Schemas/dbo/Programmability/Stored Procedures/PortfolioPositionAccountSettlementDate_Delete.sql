USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioPositionAccountSettlementDate_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioPositionAccountSettlementDate_Delete]
GO

CREATE PROCEDURE DBO.[PortfolioPositionAccountSettlementDate_Delete]
		@PortfolioPositionAccountSettlementDateId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PortfolioPositionAccountSettlementDate_hst (
			PortfolioPositionAccountSettlementDateId, PositionAccountID, ReferenceDate, Quantity, TotalCost, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioPositionAccountSettlementDateId, PositionAccountID, ReferenceDate, Quantity, TotalCost, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PortfolioPositionAccountSettlementDate
	WHERE	PortfolioPositionAccountSettlementDateId = @PortfolioPositionAccountSettlementDateId

	DELETE	PortfolioPositionAccountSettlementDate
	WHERE	PortfolioPositionAccountSettlementDateId = @PortfolioPositionAccountSettlementDateId
	AND		DataVersion = @DataVersion
GO
