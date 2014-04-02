USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Industry_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Industry_Update]
GO

CREATE PROCEDURE DBO.[Industry_Update]
		@IndustryID int, 
		@ParentIndustryID int, 
		@IndustryClassificationID int, 
		@Name varchar(100), 
		@Code varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@RelativeIndexInstrumentMarketId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Industry_hst (
			IndustryID, ParentIndustryID, IndustryClassificationID, Name, Code, StartDt, UpdateUserID, DataVersion, RelativeIndexInstrumentMarketId, EndDt, LastActionUserID)
	SELECT	IndustryID, ParentIndustryID, IndustryClassificationID, Name, Code, StartDt, UpdateUserID, DataVersion, RelativeIndexInstrumentMarketId, @StartDt, @UpdateUserID
	FROM	Industry
	WHERE	IndustryID = @IndustryID

	UPDATE	Industry
	SET		ParentIndustryID = @ParentIndustryID, IndustryClassificationID = @IndustryClassificationID, Name = @Name, Code = @Code, UpdateUserID = @UpdateUserID, RelativeIndexInstrumentMarketId = @RelativeIndexInstrumentMarketId,  StartDt = @StartDt
	WHERE	IndustryID = @IndustryID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Industry
	WHERE	IndustryID = @IndustryID
	AND		@@ROWCOUNT > 0

GO
