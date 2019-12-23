USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractGroupItem_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractGroupItem_Delete]
GO

CREATE PROCEDURE DBO.[ExtractGroupItem_Delete]
		@ExtractGroupItemId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractGroupItem_hst (
			ExtractGroupItemId, ExtractGroupId, ExtractId, Ordering, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractGroupItemId, ExtractGroupId, ExtractId, Ordering, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractGroupItem
	WHERE	ExtractGroupItemId = @ExtractGroupItemId

	DELETE	ExtractGroupItem
	WHERE	ExtractGroupItemId = @ExtractGroupItemId
	AND		DataVersion = @DataVersion
GO
