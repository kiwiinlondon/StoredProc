USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityPropertyOverride_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityPropertyOverride_Update]
GO

CREATE PROCEDURE DBO.[EntityPropertyOverride_Update]
		@EntityPropertyOverrideId int, 
		@EntityID int, 
		@EntityPropertyId int, 
		@IntValue int, 
		@StringValue varchar(1000), 
		@DecimalValue numeric(27,8), 
		@DateTimeValue datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EntityPropertyOverride_hst (
			EntityPropertyOverrideId, EntityID, EntityPropertyId, IntValue, StringValue, DecimalValue, DateTimeValue, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EntityPropertyOverrideId, EntityID, EntityPropertyId, IntValue, StringValue, DecimalValue, DateTimeValue, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	EntityPropertyOverride
	WHERE	EntityPropertyOverrideId = @EntityPropertyOverrideId

	UPDATE	EntityPropertyOverride
	SET		EntityID = @EntityID, EntityPropertyId = @EntityPropertyId, IntValue = @IntValue, StringValue = @StringValue, DecimalValue = @DecimalValue, DateTimeValue = @DateTimeValue, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EntityPropertyOverrideId = @EntityPropertyOverrideId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EntityPropertyOverride
	WHERE	EntityPropertyOverrideId = @EntityPropertyOverrideId
	AND		@@ROWCOUNT > 0

GO
