USE Keeley

create table DBO.CompanySize_hst(
	CompanySizeId int not null,
	Name varchar(100) not null,
	MarketCapUSD numeric(27,8),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)