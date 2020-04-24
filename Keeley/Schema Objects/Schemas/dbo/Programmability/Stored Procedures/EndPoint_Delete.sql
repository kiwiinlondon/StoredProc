USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EndPoint_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EndPoint_Delete]
GO

CREATE PROCEDURE DBO.[EndPoint_Delete]
		@EndPointId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO EndPoint_hst (
			EndPointId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EndPointId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	EndPoint
	WHERE	EndPointId = @EndPointId

	DELETE	EndPoint
	WHERE	EndPointId = @EndPointId
	AND		DataVersion = @DataVersion
GO
