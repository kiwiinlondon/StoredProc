USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionSource_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionSource_Update]
GO

CREATE PROCEDURE DBO.[AttributionSource_Update]
		@AttributionSourceId int, 
		@Name varchar(50), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AttributionSource_hst (
			AttributionSourceId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	AttributionSourceId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	AttributionSource
	WHERE	AttributionSourceId = @AttributionSourceId

	UPDATE	AttributionSource
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	AttributionSourceId = @AttributionSourceId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AttributionSource
	WHERE	AttributionSourceId = @AttributionSourceId
	AND		@@ROWCOUNT > 0

GO
