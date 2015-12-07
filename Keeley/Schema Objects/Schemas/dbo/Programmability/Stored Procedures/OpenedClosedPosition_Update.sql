USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[OpenedClosedPosition_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[OpenedClosedPosition_Update]
GO

CREATE PROCEDURE DBO.[OpenedClosedPosition_Update]
		@PositionId int, 
		@ReferenceDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@IsOpened bit, 
		@PortfolioId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO OpenedClosedPosition_hst (
			PositionId, ReferenceDate, StartDt, UpdateUserID, DataVersion, IsOpened, PortfolioId, EndDt, LastActionUserID)
	SELECT	PositionId, ReferenceDate, StartDt, UpdateUserID, DataVersion, IsOpened, PortfolioId, @StartDt, @UpdateUserID
	FROM	OpenedClosedPosition
	WHERE	PortfolioId = @PortfolioId

	UPDATE	OpenedClosedPosition
	SET		PositionId = @PositionId, ReferenceDate = @ReferenceDate, UpdateUserID = @UpdateUserID, IsOpened = @IsOpened,  StartDt = @StartDt
	WHERE	PortfolioId = @PortfolioId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	OpenedClosedPosition
	WHERE	PortfolioId = @PortfolioId
	AND		@@ROWCOUNT > 0

GO
