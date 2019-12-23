USE Keeley

create table DBO.HistoricEzeCommissionRate_hst(
	HistoricEzeCommissionRateId int not null,
	EzeBrokerCode varchar(10) not null,
	Execution01Jan15 numeric(27,8),
	Research01Jan15 numeric(27,8),
	Execution01Feb16 numeric(27,8),
	Research01Feb16 numeric(27,8),
	Execution19Jul17 numeric(27,8),
	Research19Jul17 numeric(27,8),
	Execution05Sep17 numeric(27,8),
	Research05Sep17 numeric(27,8),
	Execution20Oct17 numeric(27,8),
	Research20Oct17 numeric(27,8),
	IsResearchUSTrade bit not null,
	IsResearchAllCFDTrade bit not null,
	IsResearchUSHKCNCFDTrade bit not null,
	IsResearchUSHKCNCFDTrade2016 bit not null,
	IsResearchAllCFDTrade2016 bit not null,
	EndDt datetime,
	LastActionUserID int)