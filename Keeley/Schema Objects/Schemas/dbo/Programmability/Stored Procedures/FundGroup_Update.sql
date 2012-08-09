USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundGroup_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundGroup_Update]
GO

CREATE PROCEDURE DBO.[FundGroup_Update]
		@FundGroupId int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@LongName varchar(70), 
		@Description varchar(200)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundGroup_hst (
			FundGroupId, Name, StartDt, UpdateUserID, DataVersion, LongName, Description, EndDt, LastActionUserID)
	SELECT	FundGroupId, Name, StartDt, UpdateUserID, DataVersion, LongName, Description, @StartDt, @UpdateUserID
	FROM	FundGroup
	WHERE	FundGroupId = @FundGroupId

	UPDATE	FundGroup
	SET		Name = @Name, UpdateUserID = @UpdateUserID, LongName = @LongName, Description = @Description,  StartDt = @StartDt
	WHERE	FundGroupId = @FundGroupId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundGroup
	WHERE	FundGroupId = @FundGroupId
	AND		@@ROWCOUNT > 0

GO
