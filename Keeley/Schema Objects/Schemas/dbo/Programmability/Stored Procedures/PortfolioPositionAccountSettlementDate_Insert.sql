USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioPositionAccountSettlementDate_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioPositionAccountSettlementDate_Insert]
GO

CREATE PROCEDURE DBO.[PortfolioPositionAccountSettlementDate_Insert]
		@PositionAccountID int, 
		@ReferenceDate datetime, 
		@Quantity numeric(27,8), 
		@TotalCost numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PortfolioPositionAccountSettlementDate
			(PositionAccountID, ReferenceDate, Quantity, TotalCost, UpdateUserID, StartDt)
	VALUES
			(@PositionAccountID, @ReferenceDate, @Quantity, @TotalCost, @UpdateUserID, @StartDt)

	SELECT	PortfolioPositionAccountSettlementDateId, StartDt, DataVersion
	FROM	PortfolioPositionAccountSettlementDate
	WHERE	PortfolioPositionAccountSettlementDateId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
