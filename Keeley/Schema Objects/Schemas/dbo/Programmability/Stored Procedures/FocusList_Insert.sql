USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FocusList_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FocusList_Insert]
GO

CREATE PROCEDURE DBO.[FocusList_Insert]
		@InstrumentMarketId int, 
		@AnalystId int, 
		@InDate datetime, 
		@InPrice numeric(27,8), 
		@StartOfYearPrice numeric(27,8), 
		@IsLong bit, 
		@OutDate datetime, 
		@OutPrice numeric(27,8), 
		@CurrentPrice numeric(27,8), 
		@CurrentPriceId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FocusList
			(InstrumentMarketId, AnalystId, InDate, InPrice, StartOfYearPrice, IsLong, OutDate, OutPrice, CurrentPrice, CurrentPriceId, UpdateUserID, StartDt)
	VALUES
			(@InstrumentMarketId, @AnalystId, @InDate, @InPrice, @StartOfYearPrice, @IsLong, @OutDate, @OutPrice, @CurrentPrice, @CurrentPriceId, @UpdateUserID, @StartDt)

	SELECT	FocusListId, StartDt, DataVersion
	FROM	FocusList
	WHERE	FocusListId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
