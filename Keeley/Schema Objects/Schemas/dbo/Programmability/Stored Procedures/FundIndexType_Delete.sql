USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundIndexType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundIndexType_Delete]
GO

CREATE PROCEDURE DBO.[FundIndexType_Delete]
		@FundIndexTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundIndexType_hst (
			FundIndexTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundIndexTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FundIndexType
	WHERE	FundIndexTypeId = @FundIndexTypeId

	DELETE	FundIndexType
	WHERE	FundIndexTypeId = @FundIndexTypeId
	AND		DataVersion = @DataVersion
GO
