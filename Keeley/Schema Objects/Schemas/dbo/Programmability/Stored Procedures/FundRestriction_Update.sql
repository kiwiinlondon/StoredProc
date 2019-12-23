USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundRestriction_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundRestriction_Update]
GO

CREATE PROCEDURE DBO.[FundRestriction_Update]
		@FundRestrictionId int, 
		@Name varchar(200), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundRestriction_hst (
			FundRestrictionId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundRestrictionId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FundRestriction
	WHERE	FundRestrictionId = @FundRestrictionId

	UPDATE	FundRestriction
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FundRestrictionId = @FundRestrictionId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundRestriction
	WHERE	FundRestrictionId = @FundRestrictionId
	AND		@@ROWCOUNT > 0

GO
