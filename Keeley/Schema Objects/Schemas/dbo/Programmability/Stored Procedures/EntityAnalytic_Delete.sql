USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityAnalytic_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityAnalytic_Delete]
GO

CREATE PROCEDURE DBO.[EntityAnalytic_Delete]
		@EntityAnalyticId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO EntityAnalytic_hst (
			EntityAnalyticId, EntityAnalyticTypeId, EntityTypeId, EntityId, SubEntityTypeId, SubEntityId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, IsLast, EndDt, LastActionUserID)
	SELECT	EntityAnalyticId, EntityAnalyticTypeId, EntityTypeId, EntityId, SubEntityTypeId, SubEntityId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, IsLast, @EndDt, @UpdateUserID
	FROM	EntityAnalytic
	WHERE	EntityAnalyticId = @EntityAnalyticId

	DELETE	EntityAnalytic
	WHERE	EntityAnalyticId = @EntityAnalyticId
	AND		DataVersion = @DataVersion
GO
