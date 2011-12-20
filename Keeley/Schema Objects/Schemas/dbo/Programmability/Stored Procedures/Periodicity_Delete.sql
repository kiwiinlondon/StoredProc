USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Periodicity_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Periodicity_Delete]
GO

CREATE PROCEDURE DBO.[Periodicity_Delete]
		@PeriodicityId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Periodicity_hst (
			PeriodicityId, PeriodicityTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PeriodicityId, PeriodicityTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Periodicity
	WHERE	PeriodicityId = @PeriodicityId

	DELETE	Periodicity
	WHERE	PeriodicityId = @PeriodicityId
	AND		DataVersion = @DataVersion
GO
