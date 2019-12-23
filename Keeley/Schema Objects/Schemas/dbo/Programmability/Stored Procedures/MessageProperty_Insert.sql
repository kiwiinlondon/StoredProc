USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[MessageProperty_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[MessageProperty_Insert]
GO

CREATE PROCEDURE DBO.[MessageProperty_Insert]
		@MessageId int, 
		@FieldName varchar(100), 
		@OriginalValue varchar(100), 
		@CurrentValue varchar(100)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into MessageProperty
			(MessageId, FieldName, OriginalValue, CurrentValue, StartDt)
	VALUES
			(@MessageId, @FieldName, @OriginalValue, @CurrentValue, @StartDt)

	SELECT	MessagePropertyId, StartDt, DataVersion
	FROM	MessageProperty
	WHERE	MessagePropertyId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
