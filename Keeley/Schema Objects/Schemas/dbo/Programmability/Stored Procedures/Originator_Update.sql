USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Originator_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Originator_Update]
GO

CREATE PROCEDURE DBO.[Originator_Update]
		@OriginatorId int, 
		@ExternalOriginatorId int, 
		@InternalOriginatorId int, 
		@InternalOriginatorId2 int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Originator_hst (
			OriginatorId, ExternalOriginatorId, InternalOriginatorId, InternalOriginatorId2, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	OriginatorId, ExternalOriginatorId, InternalOriginatorId, InternalOriginatorId2, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	Originator
	WHERE	OriginatorId = @OriginatorId

	UPDATE	Originator
	SET		ExternalOriginatorId = @ExternalOriginatorId, InternalOriginatorId = @InternalOriginatorId, InternalOriginatorId2 = @InternalOriginatorId2, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	OriginatorId = @OriginatorId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Originator
	WHERE	OriginatorId = @OriginatorId
	AND		@@ROWCOUNT > 0

GO
