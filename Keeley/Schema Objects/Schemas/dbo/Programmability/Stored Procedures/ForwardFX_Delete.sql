USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ForwardFX_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ForwardFX_Delete]
GO

CREATE PROCEDURE DBO.[ForwardFX_Delete]
		@InstrumentId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ForwardFX_hst (
			InstrumentId, BaseCurrencyId, ContraCurrencyId, IsProp, MaturityDate, StartDt, UpdateUserID, DataVersion, IsDeliverable, EndDt, LastActionUserID)
	SELECT	InstrumentId, BaseCurrencyId, ContraCurrencyId, IsProp, MaturityDate, StartDt, UpdateUserID, DataVersion, IsDeliverable, @EndDt, @UpdateUserID
	FROM	ForwardFX
	WHERE	InstrumentId = @InstrumentId

	DELETE	ForwardFX
	WHERE	InstrumentId = @InstrumentId
	AND		DataVersion = @DataVersion
GO
