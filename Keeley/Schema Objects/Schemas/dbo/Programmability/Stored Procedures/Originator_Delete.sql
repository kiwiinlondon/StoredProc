USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Originator_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Originator_Delete]
GO

CREATE PROCEDURE DBO.[Originator_Delete]
		@OriginatorId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Originator_hst (
			OriginatorId, ExternalOriginatorId, InternalOriginatorId, InternalOriginatorId2, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	OriginatorId, ExternalOriginatorId, InternalOriginatorId, InternalOriginatorId2, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Originator
	WHERE	OriginatorId = @OriginatorId

	DELETE	Originator
	WHERE	OriginatorId = @OriginatorId
	AND		DataVersion = @DataVersion
GO
