USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FocusListPrice_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FocusListPrice_Insert]
GO

CREATE PROCEDURE DBO.[FocusListPrice_Insert]
		@FocusListId int, 
		@ReferenceDate datetime, 
		@Price numeric(27,8), 
		@UpdateUserID int, 
		@RelativePrice numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FocusListPrice
			(FocusListId, ReferenceDate, Price, UpdateUserID, RelativePrice, StartDt)
	VALUES
			(@FocusListId, @ReferenceDate, @Price, @UpdateUserID, @RelativePrice, @StartDt)

	SELECT	FocusListPriceId, StartDt, DataVersion
	FROM	FocusListPrice
	WHERE	FocusListPriceId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
