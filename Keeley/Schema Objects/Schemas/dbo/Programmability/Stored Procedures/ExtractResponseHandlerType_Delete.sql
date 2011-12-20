USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractResponseHandlerType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractResponseHandlerType_Delete]
GO

CREATE PROCEDURE DBO.[ExtractResponseHandlerType_Delete]
		@ExtractResponseHandlerTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractResponseHandlerType_hst (
			ExtractResponseHandlerTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractResponseHandlerTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractResponseHandlerType
	WHERE	ExtractResponseHandlerTypeId = @ExtractResponseHandlerTypeId

	DELETE	ExtractResponseHandlerType
	WHERE	ExtractResponseHandlerTypeId = @ExtractResponseHandlerTypeId
	AND		DataVersion = @DataVersion
GO
