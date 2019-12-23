USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractOutputContainerType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractOutputContainerType_Delete]
GO

CREATE PROCEDURE DBO.[ExtractOutputContainerType_Delete]
		@ExtractOutputContainerTypeID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractOutputContainerType_hst (
			ExtractOutputContainerTypeID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractOutputContainerTypeID, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractOutputContainerType
	WHERE	ExtractOutputContainerTypeID = @ExtractOutputContainerTypeID

	DELETE	ExtractOutputContainerType
	WHERE	ExtractOutputContainerTypeID = @ExtractOutputContainerTypeID
	AND		DataVersion = @DataVersion
GO
