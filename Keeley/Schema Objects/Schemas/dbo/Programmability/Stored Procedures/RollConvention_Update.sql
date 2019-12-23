USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RollConvention_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RollConvention_Update]
GO

CREATE PROCEDURE DBO.[RollConvention_Update]
		@RollConventionId int, 
		@Name varchar(50), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO RollConvention_hst (
			RollConventionId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	RollConventionId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	RollConvention
	WHERE	RollConventionId = @RollConventionId

	UPDATE	RollConvention
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	RollConventionId = @RollConventionId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	RollConvention
	WHERE	RollConventionId = @RollConventionId
	AND		@@ROWCOUNT > 0

GO
