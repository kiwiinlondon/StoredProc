USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundAnalyticType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundAnalyticType_Delete]
GO

CREATE PROCEDURE DBO.[FundAnalyticType_Delete]
		@FundAnalyticTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundAnalyticType_hst (
			FundAnalyticTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundAnalyticTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FundAnalyticType
	WHERE	FundAnalyticTypeId = @FundAnalyticTypeId

	DELETE	FundAnalyticType
	WHERE	FundAnalyticTypeId = @FundAnalyticTypeId
	AND		DataVersion = @DataVersion
GO
