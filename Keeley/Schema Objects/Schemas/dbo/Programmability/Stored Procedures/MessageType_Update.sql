USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[MessageType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[MessageType_Update]
GO

CREATE PROCEDURE DBO.[MessageType_Update]
		@MessageTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO MessageType_hst (
			MessageTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	MessageTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	MessageType
	WHERE	MessageTypeId = @MessageTypeId

	UPDATE	MessageType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	MessageTypeId = @MessageTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	MessageType
	WHERE	MessageTypeId = @MessageTypeId
	AND		@@ROWCOUNT > 0

GO
