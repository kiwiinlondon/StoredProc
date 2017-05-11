USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DataSource_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DataSource_Update]
GO

CREATE PROCEDURE DBO.[DataSource_Update]
		@DataSourceId int, 
		@Name varchar(250), 
		@DataVersion rowversion, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO DataSource_hst (
			DataSourceId, Name, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	DataSourceId, Name, StartDt, DataVersion, UpdateUserID, @StartDt, @UpdateUserID
	FROM	DataSource
	WHERE	DataSourceId = @DataSourceId

	UPDATE	DataSource
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	DataSourceId = @DataSourceId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	DataSource
	WHERE	DataSourceId = @DataSourceId
	AND		@@ROWCOUNT > 0

GO
