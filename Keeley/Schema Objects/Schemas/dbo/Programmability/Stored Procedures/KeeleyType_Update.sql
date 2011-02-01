USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[KeeleyType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[KeeleyType_Update]
GO

CREATE PROCEDURE DBO.[KeeleyType_Update]
		@KeeleyTypeID int, 
		@Name varchar(100), 
		@AssemblyName varchar(400), 
		@TypeName varchar(400), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO KeeleyType_hst (
			KeeleyTypeID, Name, AssemblyName, TypeName, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	KeeleyTypeID, Name, AssemblyName, TypeName, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	KeeleyType
	WHERE	KeeleyTypeID = @KeeleyTypeID

	UPDATE	KeeleyType
	SET		Name = @Name, AssemblyName = @AssemblyName, TypeName = @TypeName, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	KeeleyTypeID = @KeeleyTypeID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	KeeleyType
	WHERE	KeeleyTypeID = @KeeleyTypeID
	AND		@@ROWCOUNT > 0

GO
