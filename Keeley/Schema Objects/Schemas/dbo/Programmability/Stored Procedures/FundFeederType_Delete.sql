USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundFeederType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundFeederType_Delete]
GO

CREATE PROCEDURE DBO.[FundFeederType_Delete]
		@FundFeederTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundFeederType_hst (
			FundFeederTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundFeederTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FundFeederType
	WHERE	FundFeederTypeId = @FundFeederTypeId

	DELETE	FundFeederType
	WHERE	FundFeederTypeId = @FundFeederTypeId
	AND		DataVersion = @DataVersion
GO
