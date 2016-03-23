USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FocusListPrices_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FocusListPrices_Update]
GO

CREATE PROCEDURE DBO.[FocusListPrices_Update]
		@FocusListPriceId int, 
		@FocusListId int, 
		@ReferenceDate datetime, 
		@Price numeric(27,8), 
		@AdjustmentFactor numeric(27,8), 
		@RelativePrice numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FocusListPrices_hst (
			FocusListPriceId, FocusListId, ReferenceDate, Price, AdjustmentFactor, RelativePrice, EndDt, LastActionUserID)
	SELECT	FocusListPriceId, FocusListId, ReferenceDate, Price, AdjustmentFactor, RelativePrice, @StartDt, @UpdateUserID
	FROM	FocusListPrices
	WHERE	FocusListPriceId = @FocusListPriceId

	UPDATE	FocusListPrices
	SET		FocusListId = @FocusListId, ReferenceDate = @ReferenceDate, Price = @Price, AdjustmentFactor = @AdjustmentFactor, RelativePrice = @RelativePrice,  StartDt = @StartDt
	WHERE	FocusListPriceId = @FocusListPriceId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FocusListPrices
	WHERE	FocusListPriceId = @FocusListPriceId
	AND		@@ROWCOUNT > 0

GO
