USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundGroupMember_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundGroupMember_Delete]
GO

CREATE PROCEDURE DBO.[FundGroupMember_Delete]
		@FundGroupMemberId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundGroupMember_hst (
			FundGroupMemberId, FundGroupId, FundId, StartDt, UpdateUserID, DataVersion, BookId, EndDt, LastActionUserID)
	SELECT	FundGroupMemberId, FundGroupId, FundId, StartDt, UpdateUserID, DataVersion, BookId, @EndDt, @UpdateUserID
	FROM	FundGroupMember
	WHERE	FundGroupMemberId = @FundGroupMemberId

	DELETE	FundGroupMember
	WHERE	FundGroupMemberId = @FundGroupMemberId
	AND		DataVersion = @DataVersion
GO
