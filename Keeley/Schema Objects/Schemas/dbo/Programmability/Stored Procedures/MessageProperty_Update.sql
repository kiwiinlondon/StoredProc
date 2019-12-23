USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[MessageProperty_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[MessageProperty_Update]
GO

CREATE PROCEDURE DBO.[MessageProperty_Update]
		@MessagePropertyId int, 
		@MessageId int, 
		@FieldName varchar(100), 
		@OriginalValue varchar(100), 
		@CurrentValue varchar(100)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO MessageProperty_hst (
			MessagePropertyId, MessageId, FieldName, OriginalValue, CurrentValue, EndDt, LastActionUserID)
	SELECT	MessagePropertyId, MessageId, FieldName, OriginalValue, CurrentValue, @StartDt, @UpdateUserID
	FROM	MessageProperty
	WHERE	MessagePropertyId = @MessagePropertyId

	UPDATE	MessageProperty
	SET		MessageId = @MessageId, FieldName = @FieldName, OriginalValue = @OriginalValue, CurrentValue = @CurrentValue,  StartDt = @StartDt
	WHERE	MessagePropertyId = @MessagePropertyId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	MessageProperty
	WHERE	MessagePropertyId = @MessagePropertyId
	AND		@@ROWCOUNT > 0

GO
