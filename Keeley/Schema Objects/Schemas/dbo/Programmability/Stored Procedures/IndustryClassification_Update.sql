USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IndustryClassification_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IndustryClassification_Update]
GO

CREATE PROCEDURE DBO.[IndustryClassification_Update]
		@IndustryClassificationID int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO IndustryClassification_hst (
			IndustryClassificationID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	IndustryClassificationID, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	IndustryClassification
	WHERE	IndustryClassificationID = @IndustryClassificationID

	UPDATE	IndustryClassification
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	IndustryClassificationID = @IndustryClassificationID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	IndustryClassification
	WHERE	IndustryClassificationID = @IndustryClassificationID
	AND		@@ROWCOUNT > 0

GO
