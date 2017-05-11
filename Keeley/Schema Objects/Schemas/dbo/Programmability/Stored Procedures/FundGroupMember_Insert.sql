USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundGroupMember_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundGroupMember_Insert]
GO

CREATE PROCEDURE DBO.[FundGroupMember_Insert]
		@FundGroupId int, 
		@FundId int, 
		@UpdateUserID int, 
		@BookId int, 
		@IncludeOnlyLongs bit, 
		@UseBookNav bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundGroupMember
			(FundGroupId, FundId, UpdateUserID, BookId, IncludeOnlyLongs, UseBookNav, StartDt)
	VALUES
			(@FundGroupId, @FundId, @UpdateUserID, @BookId, @IncludeOnlyLongs, @UseBookNav, @StartDt)

	SELECT	FundGroupMemberId, StartDt, DataVersion
	FROM	FundGroupMember
	WHERE	FundGroupMemberId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
