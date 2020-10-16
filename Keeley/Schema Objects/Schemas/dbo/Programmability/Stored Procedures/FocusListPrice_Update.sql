USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FocusListPrice_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FocusListPrice_Update]
GO

CREATE PROCEDURE DBO.[FocusListPrice_Update]
		@FocusListPriceId int, 
		@FocusListId int, 
		@ReferenceDate datetime, 
		@Price numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@RelativePrice numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FocusListPrice_hst (
			FocusListPriceId, FocusListId, ReferenceDate, Price, StartDt, UpdateUserID, DataVersion, RelativePrice, EndDt, LastActionUserID)
	SELECT	FocusListPriceId, FocusListId, ReferenceDate, Price, StartDt, UpdateUserID, DataVersion, RelativePrice, @StartDt, @UpdateUserID
	FROM	FocusListPrice
	WHERE	FocusListPriceId = @FocusListPriceId

	UPDATE	FocusListPrice
	SET		FocusListId = @FocusListId, ReferenceDate = @ReferenceDate, Price = @Price, UpdateUserID = @UpdateUserID, RelativePrice = @RelativePrice,  StartDt = @StartDt
	WHERE	FocusListPriceId = @FocusListPriceId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FocusListPrice
	WHERE	FocusListPriceId = @FocusListPriceId
	AND		@@ROWCOUNT > 0

GO
