USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientSubType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientSubType_Update]
GO

CREATE PROCEDURE DBO.[ClientSubType_Update]
		@ClientSubTypeId int, 
		@Name varchar(100), 
		@ClientTypeId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientSubType_hst (
			ClientSubTypeId, Name, ClientTypeId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClientSubTypeId, Name, ClientTypeId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ClientSubType
	WHERE	ClientSubTypeId = @ClientSubTypeId

	UPDATE	ClientSubType
	SET		Name = @Name, ClientTypeId = @ClientTypeId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ClientSubTypeId = @ClientSubTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientSubType
	WHERE	ClientSubTypeId = @ClientSubTypeId
	AND		@@ROWCOUNT > 0

GO
