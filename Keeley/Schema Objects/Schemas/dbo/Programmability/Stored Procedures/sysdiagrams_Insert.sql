USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[sysdiagrams_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[sysdiagrams_Insert]
GO

CREATE PROCEDURE DBO.[sysdiagrams_Insert]
		@name sysname, 
		@principal_id int, 
		@version int, 
		@definition varbinary(MAX)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into sysdiagrams
			(name, principal_id, version, definition, StartDt)
	VALUES
			(@name, @principal_id, @version, @definition, @StartDt)

	SELECT	diagram_id, StartDt, DataVersion
	FROM	sysdiagrams
	WHERE	diagram_id = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
