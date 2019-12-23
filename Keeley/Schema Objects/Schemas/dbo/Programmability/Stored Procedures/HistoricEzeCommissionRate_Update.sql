USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[HistoricEzeCommissionRate_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[HistoricEzeCommissionRate_Update]
GO

CREATE PROCEDURE DBO.[HistoricEzeCommissionRate_Update]
		@HistoricEzeCommissionRateId int, 
		@EzeBrokerCode varchar(10), 
		@Execution01Jan15 numeric(27,8), 
		@Research01Jan15 numeric(27,8), 
		@Execution01Feb16 numeric(27,8), 
		@Research01Feb16 numeric(27,8), 
		@Execution19Jul17 numeric(27,8), 
		@Research19Jul17 numeric(27,8), 
		@Execution05Sep17 numeric(27,8), 
		@Research05Sep17 numeric(27,8), 
		@Execution20Oct17 numeric(27,8), 
		@Research20Oct17 numeric(27,8), 
		@IsResearchUSTrade bit, 
		@IsResearchAllCFDTrade bit, 
		@IsResearchUSHKCNCFDTrade bit, 
		@IsResearchUSHKCNCFDTrade2016 bit, 
		@IsResearchAllCFDTrade2016 bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO HistoricEzeCommissionRate_hst (
			HistoricEzeCommissionRateId, EzeBrokerCode, Execution01Jan15, Research01Jan15, Execution01Feb16, Research01Feb16, Execution19Jul17, Research19Jul17, Execution05Sep17, Research05Sep17, Execution20Oct17, Research20Oct17, IsResearchUSTrade, IsResearchAllCFDTrade, IsResearchUSHKCNCFDTrade, IsResearchUSHKCNCFDTrade2016, IsResearchAllCFDTrade2016, EndDt, LastActionUserID)
	SELECT	HistoricEzeCommissionRateId, EzeBrokerCode, Execution01Jan15, Research01Jan15, Execution01Feb16, Research01Feb16, Execution19Jul17, Research19Jul17, Execution05Sep17, Research05Sep17, Execution20Oct17, Research20Oct17, IsResearchUSTrade, IsResearchAllCFDTrade, IsResearchUSHKCNCFDTrade, IsResearchUSHKCNCFDTrade2016, IsResearchAllCFDTrade2016, @StartDt, @UpdateUserID
	FROM	HistoricEzeCommissionRate
	WHERE	HistoricEzeCommissionRateId = @HistoricEzeCommissionRateId

	UPDATE	HistoricEzeCommissionRate
	SET		EzeBrokerCode = @EzeBrokerCode, Execution01Jan15 = @Execution01Jan15, Research01Jan15 = @Research01Jan15, Execution01Feb16 = @Execution01Feb16, Research01Feb16 = @Research01Feb16, Execution19Jul17 = @Execution19Jul17, Research19Jul17 = @Research19Jul17, Execution05Sep17 = @Execution05Sep17, Research05Sep17 = @Research05Sep17, Execution20Oct17 = @Execution20Oct17, Research20Oct17 = @Research20Oct17, IsResearchUSTrade = @IsResearchUSTrade, IsResearchAllCFDTrade = @IsResearchAllCFDTrade, IsResearchUSHKCNCFDTrade = @IsResearchUSHKCNCFDTrade, IsResearchUSHKCNCFDTrade2016 = @IsResearchUSHKCNCFDTrade2016, IsResearchAllCFDTrade2016 = @IsResearchAllCFDTrade2016,  StartDt = @StartDt
	WHERE	HistoricEzeCommissionRateId = @HistoricEzeCommissionRateId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	HistoricEzeCommissionRate
	WHERE	HistoricEzeCommissionRateId = @HistoricEzeCommissionRateId
	AND		@@ROWCOUNT > 0

GO
