USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityAnalytic_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityAnalytic_Update]
GO

CREATE PROCEDURE DBO.[EntityAnalytic_Update]
		@EntityAnalyticId int, 
		@EntityAnalyticTypeId int, 
		@EntityTypeId int, 
		@EntityId int, 
		@SubEntityTypeId int, 
		@SubEntityId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@IsLast bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EntityAnalytic_hst (
			EntityAnalyticId, EntityAnalyticTypeId, EntityTypeId, EntityId, SubEntityTypeId, SubEntityId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, IsLast, EndDt, LastActionUserID)
	SELECT	EntityAnalyticId, EntityAnalyticTypeId, EntityTypeId, EntityId, SubEntityTypeId, SubEntityId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, IsLast, @StartDt, @UpdateUserID
	FROM	EntityAnalytic
	WHERE	EntityAnalyticId = @EntityAnalyticId

	UPDATE	EntityAnalytic
	SET		EntityAnalyticTypeId = @EntityAnalyticTypeId, EntityTypeId = @EntityTypeId, EntityId = @EntityId, SubEntityTypeId = @SubEntityTypeId, SubEntityId = @SubEntityId, ReferenceDate = @ReferenceDate, Value = @Value, UpdateUserID = @UpdateUserID, IsLast = @IsLast,  StartDt = @StartDt
	WHERE	EntityAnalyticId = @EntityAnalyticId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EntityAnalytic
	WHERE	EntityAnalyticId = @EntityAnalyticId
	AND		@@ROWCOUNT > 0

GO
