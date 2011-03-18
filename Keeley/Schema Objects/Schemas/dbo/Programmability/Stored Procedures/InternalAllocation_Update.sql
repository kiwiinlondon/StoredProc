USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InternalAllocation_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InternalAllocation_Update]
GO

CREATE PROCEDURE DBO.[InternalAllocation_Update]
		@InternalAllocationID int, 
		@EventID int, 
		@FMContEventInd varchar(1), 
		@FMContEventId int, 
		@IsMatched bit, 
		@AccountID int, 
		@BookID int, 
		@Quantity numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@FMOriginalContEventId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InternalAllocation_hst (
			InternalAllocationID, EventID, FMContEventInd, FMContEventId, IsMatched, AccountID, BookID, Quantity, StartDt, UpdateUserID, DataVersion, FMOriginalContEventId, EndDt, LastActionUserID)
	SELECT	InternalAllocationID, EventID, FMContEventInd, FMContEventId, IsMatched, AccountID, BookID, Quantity, StartDt, UpdateUserID, DataVersion, FMOriginalContEventId, @StartDt, @UpdateUserID
	FROM	InternalAllocation
	WHERE	InternalAllocationID = @InternalAllocationID

	UPDATE	InternalAllocation
	SET		EventID = @EventID, FMContEventInd = @FMContEventInd, FMContEventId = @FMContEventId, IsMatched = @IsMatched, AccountID = @AccountID, BookID = @BookID, Quantity = @Quantity, UpdateUserID = @UpdateUserID, FMOriginalContEventId = @FMOriginalContEventId,  StartDt = @StartDt
	WHERE	InternalAllocationID = @InternalAllocationID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InternalAllocation
	WHERE	InternalAllocationID = @InternalAllocationID
	AND		@@ROWCOUNT > 0

GO
