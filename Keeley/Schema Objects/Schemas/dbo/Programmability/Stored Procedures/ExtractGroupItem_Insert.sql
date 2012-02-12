USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractGroupItem_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractGroupItem_Insert]
GO

CREATE PROCEDURE DBO.[ExtractGroupItem_Insert]
		@ExtractGroupId int, 
		@ExtractId int, 
		@Ordering int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractGroupItem
			(ExtractGroupId, ExtractId, Ordering, UpdateUserID, StartDt)
	VALUES
			(@ExtractGroupId, @ExtractId, @Ordering, @UpdateUserID, @StartDt)

	SELECT	ExtractGroupItemId, StartDt, DataVersion
	FROM	ExtractGroupItem
	WHERE	ExtractGroupItemId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
