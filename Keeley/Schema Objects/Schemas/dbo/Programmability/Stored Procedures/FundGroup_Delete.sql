USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundGroup_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundGroup_Delete]
GO

CREATE PROCEDURE DBO.[FundGroup_Delete]
		@FundGroupId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundGroup_hst (
			FundGroupId, Name, StartDt, UpdateUserID, DataVersion, LongName, Description, EndDt, LastActionUserID)
	SELECT	FundGroupId, Name, StartDt, UpdateUserID, DataVersion, LongName, Description, @EndDt, @UpdateUserID
	FROM	FundGroup
	WHERE	FundGroupId = @FundGroupId

	DELETE	FundGroup
	WHERE	FundGroupId = @FundGroupId
	AND		DataVersion = @DataVersion
GO
