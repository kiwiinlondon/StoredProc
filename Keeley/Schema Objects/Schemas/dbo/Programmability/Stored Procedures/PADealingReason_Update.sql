USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PADealingReason_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PADealingReason_Update]
GO

CREATE PROCEDURE DBO.[PADealingReason_Update]
		@PADealingReasonID int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PADealingReason_hst (
			PADealingReasonID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PADealingReasonID, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PADealingReason
	WHERE	PADealingReasonID = @PADealingReasonID

	UPDATE	PADealingReason
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PADealingReasonID = @PADealingReasonID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PADealingReason
	WHERE	PADealingReasonID = @PADealingReasonID
	AND		@@ROWCOUNT > 0

GO
