USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IndexConstituent_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IndexConstituent_Insert]
GO

CREATE PROCEDURE DBO.[IndexConstituent_Insert]
		@InstrumentId int, 
		@ConstituentInstrumentId int, 
		@ReferenceDate datetime, 
		@Weighting numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into IndexConstituent
			(InstrumentId, ConstituentInstrumentId, ReferenceDate, Weighting, UpdateUserID, StartDt)
	VALUES
			(@InstrumentId, @ConstituentInstrumentId, @ReferenceDate, @Weighting, @UpdateUserID, @StartDt)

	SELECT	IndexConstituentId, StartDt, DataVersion
	FROM	IndexConstituent
	WHERE	IndexConstituentId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
