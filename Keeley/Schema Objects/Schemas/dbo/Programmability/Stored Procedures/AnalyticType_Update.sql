USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AnalyticType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AnalyticType_Update]
GO

CREATE PROCEDURE DBO.[AnalyticType_Update]
		@AnalyticTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@FMValueSpecId int, 
		@BloombergMnemonic varchar(100)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AnalyticType_hst (
			AnalyticTypeId, Name, StartDt, UpdateUserID, DataVersion, FMValueSpecId, BloombergMnemonic, EndDt, LastActionUserID)
	SELECT	AnalyticTypeId, Name, StartDt, UpdateUserID, DataVersion, FMValueSpecId, BloombergMnemonic, @StartDt, @UpdateUserID
	FROM	AnalyticType
	WHERE	AnalyticTypeId = @AnalyticTypeId

	UPDATE	AnalyticType
	SET		Name = @Name, UpdateUserID = @UpdateUserID, FMValueSpecId = @FMValueSpecId, BloombergMnemonic = @BloombergMnemonic,  StartDt = @StartDt
	WHERE	AnalyticTypeId = @AnalyticTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AnalyticType
	WHERE	AnalyticTypeId = @AnalyticTypeId
	AND		@@ROWCOUNT > 0

GO
