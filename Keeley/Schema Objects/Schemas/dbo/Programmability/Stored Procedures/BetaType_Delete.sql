USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BetaType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BetaType_Delete]
GO

CREATE PROCEDURE DBO.[BetaType_Delete]
		@BetaTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO BetaType_hst (
			BetaTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	BetaTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	BetaType
	WHERE	BetaTypeId = @BetaTypeId

	DELETE	BetaType
	WHERE	BetaTypeId = @BetaTypeId
	AND		DataVersion = @DataVersion
GO
