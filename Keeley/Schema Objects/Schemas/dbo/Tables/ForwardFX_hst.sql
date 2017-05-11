USE Keeley

create table DBO.ForwardFX_hst(
	InstrumentId int not null,
	BaseCurrencyId int not null,
	ContraCurrencyId int not null,
	IsProp bit not null,
	MaturityDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	IsDeliverable bit not null,
	EndDt datetime,
	LastActionUserID int)