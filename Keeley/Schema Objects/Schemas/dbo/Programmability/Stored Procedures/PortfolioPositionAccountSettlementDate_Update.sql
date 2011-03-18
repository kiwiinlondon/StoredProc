USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioPositionAccountSettlementDate_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioPositionAccountSettlementDate_Update]
GO

CREATE PROCEDURE DBO.[PortfolioPositionAccountSettlementDate_Update]
		@PortfolioPositionAccountSettlementDateId int, 
		@PositionAccountID int, 
		@ReferenceDate datetime, 
		@Quantity numeric(27,8), 
		@TotalCost numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PortfolioPositionAccountSettlementDate_hst (
			PortfolioPositionAccountSettlementDateId, PositionAccountID, ReferenceDate, Quantity, TotalCost, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioPositionAccountSettlementDateId, PositionAccountID, ReferenceDate, Quantity, TotalCost, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PortfolioPositionAccountSettlementDate
	WHERE	PortfolioPositionAccountSettlementDateId = @PortfolioPositionAccountSettlementDateId

	UPDATE	PortfolioPositionAccountSettlementDate
	SET		PositionAccountID = @PositionAccountID, ReferenceDate = @ReferenceDate, Quantity = @Quantity, TotalCost = @TotalCost, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PortfolioPositionAccountSettlementDateId = @PortfolioPositionAccountSettlementDateId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PortfolioPositionAccountSettlementDate
	WHERE	PortfolioPositionAccountSettlementDateId = @PortfolioPositionAccountSettlementDateId
	AND		@@ROWCOUNT > 0

GO
