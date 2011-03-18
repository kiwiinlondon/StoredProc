USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[sysdiagrams_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[sysdiagrams_Delete]
GO

CREATE PROCEDURE DBO.[sysdiagrams_Delete]
		@diagram_id int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO sysdiagrams_hst (
			name, principal_id, diagram_id, version, definition, EndDt, LastActionUserID)
	SELECT	name, principal_id, diagram_id, version, definition, @EndDt, @UpdateUserID
	FROM	sysdiagrams
	WHERE	diagram_id = @diagram_id

	DELETE	sysdiagrams
	WHERE	diagram_id = @diagram_id
	AND		DataVersion = @DataVersion
GO
