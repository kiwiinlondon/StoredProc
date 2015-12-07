USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[OpenedClosedPosition_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[OpenedClosedPosition_Insert]
GO

CREATE PROCEDURE DBO.[OpenedClosedPosition_Insert]
		@PositionId int, 
		@ReferenceDate datetime, 
		@UpdateUserID int, 
		@IsOpened bit, 
		@PortfolioId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into OpenedClosedPosition
			(PositionId, ReferenceDate, UpdateUserID, IsOpened, PortfolioId, StartDt)
	VALUES
			(@PositionId, @ReferenceDate, @UpdateUserID, @IsOpened, @PortfolioId, @StartDt)

	SELECT	PortfolioId, StartDt, DataVersion
	FROM	OpenedClosedPosition
	WHERE	PortfolioId = @PortfolioId
	AND		@@ROWCOUNT > 0

GO
