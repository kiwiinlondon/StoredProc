USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityPropertyOverride_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityPropertyOverride_Insert]
GO

CREATE PROCEDURE DBO.[EntityPropertyOverride_Insert]
		@EntityID int, 
		@EntityPropertyId int, 
		@IntValue int, 
		@StringValue varchar(1000), 
		@DecimalValue numeric(27,8), 
		@DateTimeValue datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into EntityPropertyOverride
			(EntityID, EntityPropertyId, IntValue, StringValue, DecimalValue, DateTimeValue, UpdateUserID, StartDt)
	VALUES
			(@EntityID, @EntityPropertyId, @IntValue, @StringValue, @DecimalValue, @DateTimeValue, @UpdateUserID, @StartDt)

	SELECT	EntityPropertyOverrideId, StartDt, DataVersion
	FROM	EntityPropertyOverride
	WHERE	EntityPropertyOverrideId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
