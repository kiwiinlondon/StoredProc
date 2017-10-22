USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundIndexType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundIndexType_Update]
GO

CREATE PROCEDURE DBO.[FundIndexType_Update]
		@FundIndexTypeId int, 
		@Name varchar(150), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundIndexType_hst (
			FundIndexTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundIndexTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FundIndexType
	WHERE	FundIndexTypeId = @FundIndexTypeId

	UPDATE	FundIndexType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FundIndexTypeId = @FundIndexTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundIndexType
	WHERE	FundIndexTypeId = @FundIndexTypeId
	AND		@@ROWCOUNT > 0

GO
