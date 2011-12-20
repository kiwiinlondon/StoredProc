USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Extract_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Extract_Delete]
GO

CREATE PROCEDURE DBO.[Extract_Delete]
		@ExtractID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Extract_hst (
			ExtractID, ExtractTypeId, Name, StartDt, UpdateUserID, DataVersion, ExtractOutputTypeID, ExtractRunnerTypeID, ExtractInputTypeID, ExtractDeliveryTypeID, SendIfEmpty, ExtractOutputContainerTypeID, ExtractResponseHandlerTypeId, EndDt, LastActionUserID)
	SELECT	ExtractID, ExtractTypeId, Name, StartDt, UpdateUserID, DataVersion, ExtractOutputTypeID, ExtractRunnerTypeID, ExtractInputTypeID, ExtractDeliveryTypeID, SendIfEmpty, ExtractOutputContainerTypeID, ExtractResponseHandlerTypeId, @EndDt, @UpdateUserID
	FROM	Extract
	WHERE	ExtractID = @ExtractID

	DELETE	Extract
	WHERE	ExtractID = @ExtractID
	AND		DataVersion = @DataVersion
GO
