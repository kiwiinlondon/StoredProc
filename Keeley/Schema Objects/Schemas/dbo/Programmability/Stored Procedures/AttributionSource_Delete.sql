USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionSource_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionSource_Delete]
GO

CREATE PROCEDURE DBO.[AttributionSource_Delete]
		@AttributionSourceId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO AttributionSource_hst (
			AttributionSourceId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	AttributionSourceId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	AttributionSource
	WHERE	AttributionSourceId = @AttributionSourceId

	DELETE	AttributionSource
	WHERE	AttributionSourceId = @AttributionSourceId
	AND		DataVersion = @DataVersion
GO
