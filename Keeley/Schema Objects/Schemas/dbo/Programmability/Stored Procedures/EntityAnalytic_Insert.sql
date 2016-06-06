USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityAnalytic_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityAnalytic_Insert]
GO

CREATE PROCEDURE DBO.[EntityAnalytic_Insert]
		@EntityAnalyticTypeId int, 
		@EntityTypeId int, 
		@EntityId int, 
		@SubEntityTypeId int, 
		@SubEntityId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@IsLast bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into EntityAnalytic
			(EntityAnalyticTypeId, EntityTypeId, EntityId, SubEntityTypeId, SubEntityId, ReferenceDate, Value, UpdateUserID, IsLast, StartDt)
	VALUES
			(@EntityAnalyticTypeId, @EntityTypeId, @EntityId, @SubEntityTypeId, @SubEntityId, @ReferenceDate, @Value, @UpdateUserID, @IsLast, @StartDt)

	SELECT	EntityAnalyticId, StartDt, DataVersion
	FROM	EntityAnalytic
	WHERE	EntityAnalyticId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
