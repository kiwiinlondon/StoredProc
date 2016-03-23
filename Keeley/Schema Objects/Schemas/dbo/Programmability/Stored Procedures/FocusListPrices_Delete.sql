USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FocusListPrices_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FocusListPrices_Delete]
GO

CREATE PROCEDURE DBO.[FocusListPrices_Delete]
		@FocusListPriceId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FocusListPrices_hst (
			FocusListPriceId, FocusListId, ReferenceDate, Price, AdjustmentFactor, RelativePrice, EndDt, LastActionUserID)
	SELECT	FocusListPriceId, FocusListId, ReferenceDate, Price, AdjustmentFactor, RelativePrice, @EndDt, @UpdateUserID
	FROM	FocusListPrices
	WHERE	FocusListPriceId = @FocusListPriceId

	DELETE	FocusListPrices
	WHERE	FocusListPriceId = @FocusListPriceId
	AND		DataVersion = @DataVersion
GO
