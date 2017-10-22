USE Keeley

create table DBO.PnlType_hst(
	PnlTypeId int not null,
	Name varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	MultiplyByPercentageOfFund bit,
	EndDt datetime,
	LastActionUserID int)