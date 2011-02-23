USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FMContractMapping_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FMContractMapping_Delete]
GO

CREATE PROCEDURE DBO.[FMContractMapping_Delete]
		@FMContId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FMContractMapping_hst (
			FMContId, InstrumentID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FMContId, InstrumentID, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FMContractMapping
	WHERE	FMContId = @FMContId

	DELETE	FMContractMapping
	WHERE	FMContId = @FMContId
	AND		DataVersion = @DataVersion
GO
