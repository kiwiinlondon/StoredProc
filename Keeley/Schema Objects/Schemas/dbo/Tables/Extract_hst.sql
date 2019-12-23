USE Keeley

create table DBO.Extract_hst(
	ExtractID int not null,
	ExtractTypeId int not null,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	ExtractOutputTypeID int not null,
	ExtractRunnerTypeID int not null,
	ExtractInputTypeID int not null,
	ExtractDeliveryTypeID int not null,
	SendIfEmpty bit not null,
	ExtractOutputContainerTypeID int not null,
	ExtractResponseHandlerTypeId int,
	EndDt datetime,
	LastActionUserID int)