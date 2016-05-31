USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundAnalyticType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundAnalyticType_Update]
GO

CREATE PROCEDURE DBO.[FundAnalyticType_Update]
		@FundAnalyticTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundAnalyticType_hst (
			FundAnalyticTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundAnalyticTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FundAnalyticType
	WHERE	FundAnalyticTypeId = @FundAnalyticTypeId

	UPDATE	FundAnalyticType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FundAnalyticTypeId = @FundAnalyticTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundAnalyticType
	WHERE	FundAnalyticTypeId = @FundAnalyticTypeId
	AND		@@ROWCOUNT > 0

GO
