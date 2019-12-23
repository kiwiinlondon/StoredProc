USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[MessageQueue_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[MessageQueue_Update]
GO

CREATE PROCEDURE DBO.[MessageQueue_Update]
		@MessageId int, 
		@MessageTypeId int, 
		@Message varchar(512), 
		@ChangeType char, 
		@MessageSource varchar(50)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO MessageQueue_hst (
			MessageId, MessageTypeId, Message, ChangeType, MessageSource, StartDt, EndDt, LastActionUserID)
	SELECT	MessageId, MessageTypeId, Message, ChangeType, MessageSource, StartDt, @StartDt, @UpdateUserID
	FROM	MessageQueue
	WHERE	MessageId = @MessageId

	UPDATE	MessageQueue
	SET		MessageTypeId = @MessageTypeId, Message = @Message, ChangeType = @ChangeType, MessageSource = @MessageSource,  StartDt = @StartDt
	WHERE	MessageId = @MessageId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	MessageQueue
	WHERE	MessageId = @MessageId
	AND		@@ROWCOUNT > 0

GO
