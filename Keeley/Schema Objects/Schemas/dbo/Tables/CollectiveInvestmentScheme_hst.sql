USE Keeley

create table DBO.CollectiveInvestmentScheme_hst(
	InstrumentID int not null,
	DealingFrequencyId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)