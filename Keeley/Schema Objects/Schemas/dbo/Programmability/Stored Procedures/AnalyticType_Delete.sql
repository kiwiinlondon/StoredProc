USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AnalyticType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AnalyticType_Delete]
GO

CREATE PROCEDURE DBO.[AnalyticType_Delete]
		@AnalyticTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO AnalyticType_hst (
			AnalyticTypeId, Name, StartDt, UpdateUserID, DataVersion, FMValueSpecId, BloombergMnemonic, EndDt, LastActionUserID)
	SELECT	AnalyticTypeId, Name, StartDt, UpdateUserID, DataVersion, FMValueSpecId, BloombergMnemonic, @EndDt, @UpdateUserID
	FROM	AnalyticType
	WHERE	AnalyticTypeId = @AnalyticTypeId

	DELETE	AnalyticType
	WHERE	AnalyticTypeId = @AnalyticTypeId
	AND		DataVersion = @DataVersion
GO
