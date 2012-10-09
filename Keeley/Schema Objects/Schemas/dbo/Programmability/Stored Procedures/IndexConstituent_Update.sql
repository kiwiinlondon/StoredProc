USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IndexConstituent_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IndexConstituent_Update]
GO

CREATE PROCEDURE DBO.[IndexConstituent_Update]
		@IndexConstituentId int, 
		@InstrumentId int, 
		@ConstituentInstrumentId int, 
		@ReferenceDate datetime, 
		@Weighting numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO IndexConstituent_hst (
			IndexConstituentId, InstrumentId, ConstituentInstrumentId, ReferenceDate, Weighting, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	IndexConstituentId, InstrumentId, ConstituentInstrumentId, ReferenceDate, Weighting, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	IndexConstituent
	WHERE	IndexConstituentId = @IndexConstituentId

	UPDATE	IndexConstituent
	SET		InstrumentId = @InstrumentId, ConstituentInstrumentId = @ConstituentInstrumentId, ReferenceDate = @ReferenceDate, Weighting = @Weighting, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	IndexConstituentId = @IndexConstituentId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	IndexConstituent
	WHERE	IndexConstituentId = @IndexConstituentId
	AND		@@ROWCOUNT > 0

GO
