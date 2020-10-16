USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FocusListPrice_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FocusListPrice_Delete]
GO

CREATE PROCEDURE DBO.[FocusListPrice_Delete]
		@FocusListPriceId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FocusListPrice_hst (
			FocusListPriceId, FocusListId, ReferenceDate, Price, StartDt, UpdateUserID, DataVersion, RelativePrice, EndDt, LastActionUserID)
	SELECT	FocusListPriceId, FocusListId, ReferenceDate, Price, StartDt, UpdateUserID, DataVersion, RelativePrice, @EndDt, @UpdateUserID
	FROM	FocusListPrice
	WHERE	FocusListPriceId = @FocusListPriceId

	DELETE	FocusListPrice
	WHERE	FocusListPriceId = @FocusListPriceId
	AND		DataVersion = @DataVersion
GO
