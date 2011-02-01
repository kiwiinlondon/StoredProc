USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[KeeleyType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[KeeleyType_Delete]
GO

CREATE PROCEDURE DBO.[KeeleyType_Delete]
		@KeeleyTypeID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO KeeleyType_hst (
			KeeleyTypeID, Name, AssemblyName, TypeName, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	KeeleyTypeID, Name, AssemblyName, TypeName, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	KeeleyType
	WHERE	KeeleyTypeID = @KeeleyTypeID

	DELETE	KeeleyType
	WHERE	KeeleyTypeID = @KeeleyTypeID
	AND		DataVersion = @DataVersion
GO
