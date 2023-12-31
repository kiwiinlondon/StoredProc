﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientSubType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientSubType_Delete]
GO

CREATE PROCEDURE DBO.[ClientSubType_Delete]
		@ClientSubTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ClientSubType_hst (
			ClientSubTypeId, Name, ClientTypeId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClientSubTypeId, Name, ClientTypeId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ClientSubType
	WHERE	ClientSubTypeId = @ClientSubTypeId

	DELETE	ClientSubType
	WHERE	ClientSubTypeId = @ClientSubTypeId
	AND		DataVersion = @DataVersion
GO
