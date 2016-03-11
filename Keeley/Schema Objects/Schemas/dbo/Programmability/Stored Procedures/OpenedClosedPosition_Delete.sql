USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[OpenedClosedPosition_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[OpenedClosedPosition_Delete]
GO

CREATE PROCEDURE DBO.[OpenedClosedPosition_Delete]
		@PortfolioId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO OpenedClosedPosition_hst (
			PositionId, ReferenceDate, StartDt, UpdateUserID, DataVersion, IsOpened, PortfolioId, IsNetPositionLong, IsExposureLong, IsNetPositionLongChanged, IsExposureLongChanged, IsClosed, EndDt, LastActionUserID)
	SELECT	PositionId, ReferenceDate, StartDt, UpdateUserID, DataVersion, IsOpened, PortfolioId, IsNetPositionLong, IsExposureLong, IsNetPositionLongChanged, IsExposureLongChanged, IsClosed, @EndDt, @UpdateUserID
	FROM	OpenedClosedPosition
	WHERE	PortfolioId = @PortfolioId

	DELETE	OpenedClosedPosition
	WHERE	PortfolioId = @PortfolioId
	AND		DataVersion = @DataVersion
GO
