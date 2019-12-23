USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityPropertyOverride_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityPropertyOverride_Delete]
GO

CREATE PROCEDURE DBO.[EntityPropertyOverride_Delete]
		@EntityPropertyOverrideId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO EntityPropertyOverride_hst (
			EntityPropertyOverrideId, EntityID, EntityPropertyId, IntValue, StringValue, DecimalValue, DateTimeValue, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EntityPropertyOverrideId, EntityID, EntityPropertyId, IntValue, StringValue, DecimalValue, DateTimeValue, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	EntityPropertyOverride
	WHERE	EntityPropertyOverrideId = @EntityPropertyOverrideId

	DELETE	EntityPropertyOverride
	WHERE	EntityPropertyOverrideId = @EntityPropertyOverrideId
	AND		DataVersion = @DataVersion
GO
