USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FocusListPrices_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FocusListPrices_Insert]
GO

CREATE PROCEDURE DBO.[FocusListPrices_Insert]
		@FocusListId int, 
		@ReferenceDate datetime, 
		@Price numeric(27,8), 
		@AdjustmentFactor numeric(27,8), 
		@RelativePrice numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FocusListPrices
			(FocusListId, ReferenceDate, Price, AdjustmentFactor, RelativePrice, StartDt)
	VALUES
			(@FocusListId, @ReferenceDate, @Price, @AdjustmentFactor, @RelativePrice, @StartDt)

	SELECT	FocusListPriceId, StartDt, DataVersion
	FROM	FocusListPrices
	WHERE	FocusListPriceId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
