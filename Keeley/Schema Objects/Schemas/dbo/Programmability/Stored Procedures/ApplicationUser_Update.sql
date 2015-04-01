USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ApplicationUser_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ApplicationUser_Update]
GO

CREATE PROCEDURE DBO.[ApplicationUser_Update]
		@UserID int, 
		@FMPersID int, 
		@Name varchar(100), 
		@Email varchar(100), 
		@WindowsLogin varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@Initials varchar(10), 
		@IsActive bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ApplicationUser_hst (
			UserID, FMPersID, Name, Email, WindowsLogin, StartDt, UpdateUserID, DataVersion, Initials, IsActive, EndDt, LastActionUserID)
	SELECT	UserID, FMPersID, Name, Email, WindowsLogin, StartDt, UpdateUserID, DataVersion, Initials, IsActive, @StartDt, @UpdateUserID
	FROM	ApplicationUser
	WHERE	UserID = @UserID

	UPDATE	ApplicationUser
	SET		FMPersID = @FMPersID, Name = @Name, Email = @Email, WindowsLogin = @WindowsLogin, UpdateUserID = @UpdateUserID, Initials = @Initials, IsActive = @IsActive,  StartDt = @StartDt
	WHERE	UserID = @UserID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ApplicationUser
	WHERE	UserID = @UserID
	AND		@@ROWCOUNT > 0

GO
