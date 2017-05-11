USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ApplicationUser_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ApplicationUser_Insert]
GO

CREATE PROCEDURE DBO.[ApplicationUser_Insert]
		@FMPersID int, 
		@Name varchar(100), 
		@Email varchar(100), 
		@WindowsLogin varchar(100), 
		@UpdateUserID int, 
		@Initials varchar(10), 
		@IsActive bit, 
		@UserTypeFlags int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ApplicationUser
			(FMPersID, Name, Email, WindowsLogin, UpdateUserID, Initials, IsActive, UserTypeFlags, StartDt)
	VALUES
			(@FMPersID, @Name, @Email, @WindowsLogin, @UpdateUserID, @Initials, @IsActive, @UserTypeFlags, @StartDt)

	SELECT	UserID, StartDt, DataVersion
	FROM	ApplicationUser
	WHERE	UserID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
