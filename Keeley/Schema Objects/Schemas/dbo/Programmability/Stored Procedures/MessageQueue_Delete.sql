USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[MessageQueue_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[MessageQueue_Delete]
GO

CREATE PROCEDURE DBO.[MessageQueue_Delete]
		@MessageId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO MessageQueue_hst (
			MessageId, MessageTypeId, Message, ChangeType, MessageSource, StartDt, EndDt, LastActionUserID)
	SELECT	MessageId, MessageTypeId, Message, ChangeType, MessageSource, StartDt, @EndDt, @UpdateUserID
	FROM	MessageQueue
	WHERE	MessageId = @MessageId

	DELETE	MessageQueue
	WHERE	MessageId = @MessageId
	AND		DataVersion = @DataVersion
GO
