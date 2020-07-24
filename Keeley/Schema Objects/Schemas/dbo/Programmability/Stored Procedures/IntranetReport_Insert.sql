USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IntranetReport_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IntranetReport_Insert]
GO

CREATE PROCEDURE DBO.[IntranetReport_Insert]
		@Name varchar(100), 
		@Path varchar(300), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into IntranetReport
			(Name, Path, UpdateUserID, StartDt)
	VALUES
			(@Name, @Path, @UpdateUserID, @StartDt)

	SELECT	IntranetReportId, StartDt, DataVersion
	FROM	IntranetReport
	WHERE	IntranetReportId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
