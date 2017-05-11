USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DataSource_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DataSource_Delete]
GO

CREATE PROCEDURE DBO.[DataSource_Delete]
		@DataSourceId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO DataSource_hst (
			DataSourceId, Name, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	DataSourceId, Name, StartDt, DataVersion, UpdateUserID, @EndDt, @UpdateUserID
	FROM	DataSource
	WHERE	DataSourceId = @DataSourceId

	DELETE	DataSource
	WHERE	DataSourceId = @DataSourceId
	AND		DataVersion = @DataVersion
GO
