USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IndustryClassification_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IndustryClassification_Insert]
GO

CREATE PROCEDURE DBO.[IndustryClassification_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into IndustryClassification
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	IndustryClassificationID, StartDt, DataVersion
	FROM	IndustryClassification
	WHERE	IndustryClassificationID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
