USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ApplicationUser_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ApplicationUser_Delete]

GO
CREATE PROCEDURE DBO.[ApplicationUser_Delete]
		@UserID timestamp,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ApplicationUser_hst (
			UserID, FMPersID, Name, Email, WindowsLogin, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	UserID, FMPersID, Name, Email, WindowsLogin, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ApplicationUser
	WHERE	UserID = UserID

	DELETE	ApplicationUser
	WHERE	UserID = @UserID
	AND		DataVersion = @DataVersion
GO
