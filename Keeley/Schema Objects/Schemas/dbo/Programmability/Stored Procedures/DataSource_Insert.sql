USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DataSource_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DataSource_Insert]
GO

CREATE PROCEDURE DBO.[DataSource_Insert]
		@Name varchar(250), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into DataSource
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	DataSourceId, StartDt, DataVersion
	FROM	DataSource
	WHERE	DataSourceId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
