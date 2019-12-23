USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[MessageProperty_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[MessageProperty_Delete]
GO

CREATE PROCEDURE DBO.[MessageProperty_Delete]
		@MessagePropertyId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO MessageProperty_hst (
			MessagePropertyId, MessageId, FieldName, OriginalValue, CurrentValue, EndDt, LastActionUserID)
	SELECT	MessagePropertyId, MessageId, FieldName, OriginalValue, CurrentValue, @EndDt, @UpdateUserID
	FROM	MessageProperty
	WHERE	MessagePropertyId = @MessagePropertyId

	DELETE	MessageProperty
	WHERE	MessagePropertyId = @MessagePropertyId
	AND		DataVersion = @DataVersion
GO
