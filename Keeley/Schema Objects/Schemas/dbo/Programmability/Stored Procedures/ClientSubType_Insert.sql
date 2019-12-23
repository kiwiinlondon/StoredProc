USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientSubType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientSubType_Insert]
GO

CREATE PROCEDURE DBO.[ClientSubType_Insert]
		@Name varchar(100), 
		@ClientTypeId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientSubType
			(Name, ClientTypeId, UpdateUserID, StartDt)
	VALUES
			(@Name, @ClientTypeId, @UpdateUserID, @StartDt)

	SELECT	ClientSubTypeId, StartDt, DataVersion
	FROM	ClientSubType
	WHERE	ClientSubTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
