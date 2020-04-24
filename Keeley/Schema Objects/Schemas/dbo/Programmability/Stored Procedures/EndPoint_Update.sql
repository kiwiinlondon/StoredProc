USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EndPoint_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EndPoint_Update]
GO

CREATE PROCEDURE DBO.[EndPoint_Update]
		@EndPointId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EndPoint_hst (
			EndPointId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EndPointId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	EndPoint
	WHERE	EndPointId = @EndPointId

	UPDATE	EndPoint
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EndPointId = @EndPointId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EndPoint
	WHERE	EndPointId = @EndPointId
	AND		@@ROWCOUNT > 0

GO
