USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Industry_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Industry_Delete]
GO

CREATE PROCEDURE DBO.[Industry_Delete]
		@IndustryID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Industry_hst (
			IndustryID, ParentIndustryID, IndustryClassificationID, Name, Code, StartDt, UpdateUserID, DataVersion, RelativeIndexInstrumentMarketId, EndDt, LastActionUserID)
	SELECT	IndustryID, ParentIndustryID, IndustryClassificationID, Name, Code, StartDt, UpdateUserID, DataVersion, RelativeIndexInstrumentMarketId, @EndDt, @UpdateUserID
	FROM	Industry
	WHERE	IndustryID = @IndustryID

	DELETE	Industry
	WHERE	IndustryID = @IndustryID
	AND		DataVersion = @DataVersion
GO
