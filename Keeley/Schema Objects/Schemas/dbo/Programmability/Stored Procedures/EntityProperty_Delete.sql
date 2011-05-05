USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityProperty_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityProperty_Delete]
GO

CREATE PROCEDURE DBO.[EntityProperty_Delete]
		@EntityPropertyID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO EntityProperty_hst (
			EntityPropertyID, EntityTypeId, NeedsToBeCalculated, Name, StartDt, UpdateUserID, DataVersion, PropertyOnChildEntity, TypeCode, EndDt, LastActionUserID)
	SELECT	EntityPropertyID, EntityTypeId, NeedsToBeCalculated, Name, StartDt, UpdateUserID, DataVersion, PropertyOnChildEntity, TypeCode, @EndDt, @UpdateUserID
	FROM	EntityProperty
	WHERE	EntityPropertyID = @EntityPropertyID

	DELETE	EntityProperty
	WHERE	EntityPropertyID = @EntityPropertyID
	AND		DataVersion = @DataVersion
GO
