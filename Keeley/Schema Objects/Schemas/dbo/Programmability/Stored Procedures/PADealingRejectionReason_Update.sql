USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PADealingRejectionReason_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PADealingRejectionReason_Update]
GO

CREATE PROCEDURE DBO.[PADealingRejectionReason_Update]
		@PADealingRejectionReasonID int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PADealingRejectionReason_hst (
			PADealingRejectionReasonID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PADealingRejectionReasonID, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PADealingRejectionReason
	WHERE	PADealingRejectionReasonID = @PADealingRejectionReasonID

	UPDATE	PADealingRejectionReason
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PADealingRejectionReasonID = @PADealingRejectionReasonID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PADealingRejectionReason
	WHERE	PADealingRejectionReasonID = @PADealingRejectionReasonID
	AND		@@ROWCOUNT > 0

GO
