USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PeriodicityType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PeriodicityType_Update]
GO

CREATE PROCEDURE DBO.[PeriodicityType_Update]
		@PeriodicityTypeId int, 
		@Name varchar(200), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PeriodicityType_hst (
			PeriodicityTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PeriodicityTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PeriodicityType
	WHERE	PeriodicityTypeId = @PeriodicityTypeId

	UPDATE	PeriodicityType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PeriodicityTypeId = @PeriodicityTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PeriodicityType
	WHERE	PeriodicityTypeId = @PeriodicityTypeId
	AND		@@ROWCOUNT > 0

GO
