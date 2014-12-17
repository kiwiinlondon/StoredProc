USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PADealingRejectionReason_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PADealingRejectionReason_Insert]
GO

CREATE PROCEDURE DBO.[PADealingRejectionReason_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PADealingRejectionReason
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	PADealingRejectionReasonID, StartDt, DataVersion
	FROM	PADealingRejectionReason
	WHERE	PADealingRejectionReasonID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
