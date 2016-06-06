USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityAnalyticType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityAnalyticType_Delete]
GO

CREATE PROCEDURE DBO.[EntityAnalyticType_Delete]
		@EntityAnalyticTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO EntityAnalyticType_hst (
			EntityAnalyticTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EntityAnalyticTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	EntityAnalyticType
	WHERE	EntityAnalyticTypeId = @EntityAnalyticTypeId

	DELETE	EntityAnalyticType
	WHERE	EntityAnalyticTypeId = @EntityAnalyticTypeId
	AND		DataVersion = @DataVersion
GO
