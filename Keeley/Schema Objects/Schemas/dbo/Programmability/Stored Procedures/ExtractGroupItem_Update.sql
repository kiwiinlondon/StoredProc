USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractGroupItem_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractGroupItem_Update]
GO

CREATE PROCEDURE DBO.[ExtractGroupItem_Update]
		@ExtractGroupItemId int, 
		@ExtractGroupId int, 
		@ExtractId int, 
		@Ordering int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractGroupItem_hst (
			ExtractGroupItemId, ExtractGroupId, ExtractId, Ordering, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractGroupItemId, ExtractGroupId, ExtractId, Ordering, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractGroupItem
	WHERE	ExtractGroupItemId = @ExtractGroupItemId

	UPDATE	ExtractGroupItem
	SET		ExtractGroupId = @ExtractGroupId, ExtractId = @ExtractId, Ordering = @Ordering, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtractGroupItemId = @ExtractGroupItemId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractGroupItem
	WHERE	ExtractGroupItemId = @ExtractGroupItemId
	AND		@@ROWCOUNT > 0

GO
