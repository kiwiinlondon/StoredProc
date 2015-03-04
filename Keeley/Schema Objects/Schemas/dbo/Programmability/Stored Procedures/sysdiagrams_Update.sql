USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[sysdiagrams_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[sysdiagrams_Update]
GO

CREATE PROCEDURE DBO.[sysdiagrams_Update]
		@name sysname, 
		@principal_id int, 
		@diagram_id int, 
		@version int, 
		@definition varbinary(MAX)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO sysdiagrams_hst (
			name, principal_id, diagram_id, version, definition, EndDt, LastActionUserID)
	SELECT	name, principal_id, diagram_id, version, definition, @StartDt, @UpdateUserID
	FROM	sysdiagrams
	WHERE	diagram_id = @diagram_id

	UPDATE	sysdiagrams
	SET		name = @name, principal_id = @principal_id, version = @version, definition = @definition,  StartDt = @StartDt
	WHERE	diagram_id = @diagram_id
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	sysdiagrams
	WHERE	diagram_id = @diagram_id
	AND		@@ROWCOUNT > 0

GO
