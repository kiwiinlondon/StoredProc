USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IndexType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IndexType_Update]
GO

CREATE PROCEDURE DBO.[IndexType_Update]
		@IndexTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO IndexType_hst (
			IndexTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	IndexTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	IndexType
	WHERE	IndexTypeId = @IndexTypeId

	UPDATE	IndexType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	IndexTypeId = @IndexTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	IndexType
	WHERE	IndexTypeId = @IndexTypeId
	AND		@@ROWCOUNT > 0

GO
