USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PeriodicityType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PeriodicityType_Delete]
GO

CREATE PROCEDURE DBO.[PeriodicityType_Delete]
		@PeriodicityTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PeriodicityType_hst (
			PeriodicityTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PeriodicityTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PeriodicityType
	WHERE	PeriodicityTypeId = @PeriodicityTypeId

	DELETE	PeriodicityType
	WHERE	PeriodicityTypeId = @PeriodicityTypeId
	AND		DataVersion = @DataVersion
GO
