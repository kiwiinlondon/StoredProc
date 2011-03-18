USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InternalAllocation_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InternalAllocation_Delete]
GO

CREATE PROCEDURE DBO.[InternalAllocation_Delete]
		@InternalAllocationID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO InternalAllocation_hst (
			InternalAllocationID, EventID, FMContEventInd, FMContEventId, IsMatched, AccountID, BookID, Quantity, StartDt, UpdateUserID, DataVersion, FMOriginalContEventId, EndDt, LastActionUserID)
	SELECT	InternalAllocationID, EventID, FMContEventInd, FMContEventId, IsMatched, AccountID, BookID, Quantity, StartDt, UpdateUserID, DataVersion, FMOriginalContEventId, @EndDt, @UpdateUserID
	FROM	InternalAllocation
	WHERE	InternalAllocationID = @InternalAllocationID

	DELETE	InternalAllocation
	WHERE	InternalAllocationID = @InternalAllocationID
	AND		DataVersion = @DataVersion
GO
