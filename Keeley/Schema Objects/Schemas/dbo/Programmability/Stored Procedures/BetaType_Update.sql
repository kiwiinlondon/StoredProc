USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BetaType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BetaType_Update]
GO

CREATE PROCEDURE DBO.[BetaType_Update]
		@BetaTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO BetaType_hst (
			BetaTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	BetaTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	BetaType
	WHERE	BetaTypeId = @BetaTypeId

	UPDATE	BetaType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	BetaTypeId = @BetaTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	BetaType
	WHERE	BetaTypeId = @BetaTypeId
	AND		@@ROWCOUNT > 0

GO
