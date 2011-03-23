USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InternalAllocation_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InternalAllocation_Insert]
GO

CREATE PROCEDURE DBO.[InternalAllocation_Insert]
		@EventID int, 
		@FMContEventInd varchar(1), 
		@FMContEventId int, 
		@AccountID int, 
		@BookID int, 
		@Quantity numeric(27,8), 
		@UpdateUserID int, 
		@FMOriginalContEventId int, 
		@IsCancelled bit, 
		@MatchedStatusId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into InternalAllocation
			(EventID, FMContEventInd, FMContEventId, AccountID, BookID, Quantity, UpdateUserID, FMOriginalContEventId, IsCancelled, MatchedStatusId, StartDt)
	VALUES
			(@EventID, @FMContEventInd, @FMContEventId, @AccountID, @BookID, @Quantity, @UpdateUserID, @FMOriginalContEventId, @IsCancelled, @MatchedStatusId, @StartDt)

	SELECT	InternalAllocationID, StartDt, DataVersion
	FROM	InternalAllocation
	WHERE	InternalAllocationID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
