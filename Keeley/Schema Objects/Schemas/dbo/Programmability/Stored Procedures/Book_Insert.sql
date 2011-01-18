USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Book_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Book_Insert]
GO

CREATE PROCEDURE DBO.[Book_Insert]
		@FMOrgId int, 
		@Name varchar(70), 
		@FundID int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Book
			(FMOrgId, Name, FundID, UpdateUserID, StartDt)
	VALUES
			(@FMOrgId, @Name, @FundID, @UpdateUserID, @StartDt)

	SELECT	BookID, StartDt, DataVersion
	FROM	Book
	WHERE	BookID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
