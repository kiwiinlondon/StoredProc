USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[HistoricEzeCommissionRate_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[HistoricEzeCommissionRate_Insert]
GO

CREATE PROCEDURE DBO.[HistoricEzeCommissionRate_Insert]
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

	INSERT into HistoricEzeCommissionRate
			(EzeBrokerCode, Execution01Jan15, Research01Jan15, Execution01Feb16, Research01Feb16, Execution19Jul17, Research19Jul17, Execution05Sep17, Research05Sep17, Execution20Oct17, Research20Oct17, IsResearchUSTrade, IsResearchAllCFDTrade, IsResearchUSHKCNCFDTrade, IsResearchUSHKCNCFDTrade2016, IsResearchAllCFDTrade2016, StartDt)
	VALUES
			(@EzeBrokerCode, @Execution01Jan15, @Research01Jan15, @Execution01Feb16, @Research01Feb16, @Execution19Jul17, @Research19Jul17, @Execution05Sep17, @Research05Sep17, @Execution20Oct17, @Research20Oct17, @IsResearchUSTrade, @IsResearchAllCFDTrade, @IsResearchUSHKCNCFDTrade, @IsResearchUSHKCNCFDTrade2016, @IsResearchAllCFDTrade2016, @StartDt)

	SELECT	HistoricEzeCommissionRateId, StartDt, DataVersion
	FROM	HistoricEzeCommissionRate
	WHERE	HistoricEzeCommissionRateId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
