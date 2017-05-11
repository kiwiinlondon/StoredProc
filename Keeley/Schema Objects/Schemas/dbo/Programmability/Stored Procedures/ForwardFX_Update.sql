USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ForwardFX_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ForwardFX_Update]
GO

CREATE PROCEDURE DBO.[ForwardFX_Update]
		@InstrumentId int, 
		@BaseCurrencyId int, 
		@ContraCurrencyId int, 
		@IsProp bit, 
		@MaturityDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@IsDeliverable bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ForwardFX_hst (
			InstrumentId, BaseCurrencyId, ContraCurrencyId, IsProp, MaturityDate, StartDt, UpdateUserID, DataVersion, IsDeliverable, EndDt, LastActionUserID)
	SELECT	InstrumentId, BaseCurrencyId, ContraCurrencyId, IsProp, MaturityDate, StartDt, UpdateUserID, DataVersion, IsDeliverable, @StartDt, @UpdateUserID
	FROM	ForwardFX
	WHERE	InstrumentId = @InstrumentId

	UPDATE	ForwardFX
	SET		BaseCurrencyId = @BaseCurrencyId, ContraCurrencyId = @ContraCurrencyId, IsProp = @IsProp, MaturityDate = @MaturityDate, UpdateUserID = @UpdateUserID, IsDeliverable = @IsDeliverable,  StartDt = @StartDt
	WHERE	InstrumentId = @InstrumentId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ForwardFX
	WHERE	InstrumentId = @InstrumentId
	AND		@@ROWCOUNT > 0

GO
