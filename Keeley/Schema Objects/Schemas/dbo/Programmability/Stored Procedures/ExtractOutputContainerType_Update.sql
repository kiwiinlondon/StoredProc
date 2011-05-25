USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractOutputContainerType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractOutputContainerType_Update]
GO

CREATE PROCEDURE DBO.[ExtractOutputContainerType_Update]
		@ExtractOutputContainerTypeID int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractOutputContainerType_hst (
			ExtractOutputContainerTypeID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractOutputContainerTypeID, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractOutputContainerType
	WHERE	ExtractOutputContainerTypeID = @ExtractOutputContainerTypeID

	UPDATE	ExtractOutputContainerType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtractOutputContainerTypeID = @ExtractOutputContainerTypeID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractOutputContainerType
	WHERE	ExtractOutputContainerTypeID = @ExtractOutputContainerTypeID
	AND		@@ROWCOUNT > 0

GO
