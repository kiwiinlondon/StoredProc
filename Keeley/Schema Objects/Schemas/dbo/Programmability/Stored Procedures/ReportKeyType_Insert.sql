USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportKeyType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportKeyType_Insert]
GO

CREATE PROCEDURE DBO.[ReportKeyType_Insert]
		@Name varchar(256), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ReportKeyType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	ReportKeyTypeId, StartDt, DataVersion
	FROM	ReportKeyType
	WHERE	ReportKeyTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
