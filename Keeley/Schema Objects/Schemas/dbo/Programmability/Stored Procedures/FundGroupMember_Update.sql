﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundGroupMember_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundGroupMember_Update]
GO

CREATE PROCEDURE DBO.[FundGroupMember_Update]
		@FundGroupMemberId int, 
		@FundGroupId int, 
		@FundId int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@BookId int, 
		@IncludeOnlyLongs bit, 
		@UseBookNav bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundGroupMember_hst (
			FundGroupMemberId, FundGroupId, FundId, StartDt, UpdateUserID, DataVersion, BookId, IncludeOnlyLongs, UseBookNav, EndDt, LastActionUserID)
	SELECT	FundGroupMemberId, FundGroupId, FundId, StartDt, UpdateUserID, DataVersion, BookId, IncludeOnlyLongs, UseBookNav, @StartDt, @UpdateUserID
	FROM	FundGroupMember
	WHERE	FundGroupMemberId = @FundGroupMemberId

	UPDATE	FundGroupMember
	SET		FundGroupId = @FundGroupId, FundId = @FundId, UpdateUserID = @UpdateUserID, BookId = @BookId, IncludeOnlyLongs = @IncludeOnlyLongs, UseBookNav = @UseBookNav,  StartDt = @StartDt
	WHERE	FundGroupMemberId = @FundGroupMemberId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundGroupMember
	WHERE	FundGroupMemberId = @FundGroupMemberId
	AND		@@ROWCOUNT > 0

GO
