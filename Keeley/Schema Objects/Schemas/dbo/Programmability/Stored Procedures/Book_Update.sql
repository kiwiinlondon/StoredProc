﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Book_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Book_Update]
GO

CREATE PROCEDURE DBO.[Book_Update]
		@BookID int, 
		@FMOrgId int, 
		@Name varchar(70), 
		@FundID int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@ManagerId int, 
		@EZEIdentifier varchar(100), 
		@IsPrimary bit, 
		@IsActive bit, 
		@NavIsNotUsable bit, 
		@SignOffManagerId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Book_hst (
			BookID, FMOrgId, Name, FundID, StartDt, UpdateUserID, DataVersion, ManagerId, EZEIdentifier, IsPrimary, IsActive, NavIsNotUsable, SignOffManagerId, EndDt, LastActionUserID)
	SELECT	BookID, FMOrgId, Name, FundID, StartDt, UpdateUserID, DataVersion, ManagerId, EZEIdentifier, IsPrimary, IsActive, NavIsNotUsable, SignOffManagerId, @StartDt, @UpdateUserID
	FROM	Book
	WHERE	BookID = @BookID

	UPDATE	Book
	SET		FMOrgId = @FMOrgId, Name = @Name, FundID = @FundID, UpdateUserID = @UpdateUserID, ManagerId = @ManagerId, EZEIdentifier = @EZEIdentifier, IsPrimary = @IsPrimary, IsActive = @IsActive, NavIsNotUsable = @NavIsNotUsable, SignOffManagerId = @SignOffManagerId,  StartDt = @StartDt
	WHERE	BookID = @BookID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Book
	WHERE	BookID = @BookID
	AND		@@ROWCOUNT > 0

GO
