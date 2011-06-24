USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IndustryClassification_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IndustryClassification_Delete]
GO

CREATE PROCEDURE DBO.[IndustryClassification_Delete]
		@IndustryClassificationID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO IndustryClassification_hst (
			IndustryClassificationID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	IndustryClassificationID, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	IndustryClassification
	WHERE	IndustryClassificationID = @IndustryClassificationID

	DELETE	IndustryClassification
	WHERE	IndustryClassificationID = @IndustryClassificationID
	AND		DataVersion = @DataVersion
GO
