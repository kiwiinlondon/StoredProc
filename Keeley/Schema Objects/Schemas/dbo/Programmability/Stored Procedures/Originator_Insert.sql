USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Originator_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Originator_Insert]
GO

CREATE PROCEDURE DBO.[Originator_Insert]
		@ExternalOriginatorId int, 
		@InternalOriginatorId int, 
		@InternalOriginatorId2 int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Originator
			(ExternalOriginatorId, InternalOriginatorId, InternalOriginatorId2, UpdateUserID, StartDt)
	VALUES
			(@ExternalOriginatorId, @InternalOriginatorId, @InternalOriginatorId2, @UpdateUserID, @StartDt)

	SELECT	OriginatorId, StartDt, DataVersion
	FROM	Originator
	WHERE	OriginatorId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
