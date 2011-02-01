USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[KeeleyType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[KeeleyType_Insert]
GO

CREATE PROCEDURE DBO.[KeeleyType_Insert]
		@Name varchar(100), 
		@AssemblyName varchar(400), 
		@TypeName varchar(400), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into KeeleyType
			(Name, AssemblyName, TypeName, UpdateUserID, StartDt)
	VALUES
			(@Name, @AssemblyName, @TypeName, @UpdateUserID, @StartDt)

	SELECT	KeeleyTypeID, StartDt, DataVersion
	FROM	KeeleyType
	WHERE	KeeleyTypeID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
