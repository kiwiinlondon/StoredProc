USE Keeley

create table DBO.SecurityGroupFunctionPoint_hst(
	SecurityGroupFunctionPointId int not null,
	SecurityGroupId int not null,
	FunctionPointId int not null,
	CreatePermission bit not null,
	ReadPermission bit not null,
	UpdatePermission bit not null,
	DeletePermission bit not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)