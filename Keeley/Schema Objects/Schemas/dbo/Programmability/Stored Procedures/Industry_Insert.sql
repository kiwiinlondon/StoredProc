USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Industry_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Industry_Insert]
GO

CREATE PROCEDURE DBO.[Industry_Insert]
		@ParentIndustryID int, 
		@IndustryClassificationID int, 
		@Name varchar(100), 
		@Code varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Industry
			(ParentIndustryID, IndustryClassificationID, Name, Code, UpdateUserID, StartDt)
	VALUES
			(@ParentIndustryID, @IndustryClassificationID, @Name, @Code, @UpdateUserID, @StartDt)

	SELECT	IndustryID, StartDt, DataVersion
	FROM	Industry
	WHERE	IndustryID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
