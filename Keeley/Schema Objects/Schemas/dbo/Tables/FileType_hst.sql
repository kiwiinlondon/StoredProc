USE Keeley

create table DBO.FileType_hst(
	FileTypeId int not null,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EnableManualFileUpload bit not null,
	EndDt datetime,
	LastActionUserID int)