USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundRestriction_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundRestriction_Delete]
GO

CREATE PROCEDURE DBO.[FundRestriction_Delete]
		@FundRestrictionId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundRestriction_hst (
			FundRestrictionId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundRestrictionId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FundRestriction
	WHERE	FundRestrictionId = @FundRestrictionId

	DELETE	FundRestriction
	WHERE	FundRestrictionId = @FundRestrictionId
	AND		DataVersion = @DataVersion
GO
