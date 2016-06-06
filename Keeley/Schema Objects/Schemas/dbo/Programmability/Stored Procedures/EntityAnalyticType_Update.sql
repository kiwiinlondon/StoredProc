USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityAnalyticType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityAnalyticType_Update]
GO

CREATE PROCEDURE DBO.[EntityAnalyticType_Update]
		@EntityAnalyticTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EntityAnalyticType_hst (
			EntityAnalyticTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EntityAnalyticTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	EntityAnalyticType
	WHERE	EntityAnalyticTypeId = @EntityAnalyticTypeId

	UPDATE	EntityAnalyticType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EntityAnalyticTypeId = @EntityAnalyticTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EntityAnalyticType
	WHERE	EntityAnalyticTypeId = @EntityAnalyticTypeId
	AND		@@ROWCOUNT > 0

GO
