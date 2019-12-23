USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportType_Insert]
GO

CREATE PROCEDURE DBO.[ReportType_Insert]
		@Name varchar(256), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ReportType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	ReportTypeId, StartDt, DataVersion
	FROM	ReportType
	WHERE	ReportTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
