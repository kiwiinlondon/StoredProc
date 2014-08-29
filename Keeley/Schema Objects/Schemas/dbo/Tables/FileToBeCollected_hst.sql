USE Keeley

create table DBO.FileToBeCollected_hst(
	FileToBeCollectedId int not null,
	Name varchar(70) not null,
	FileCollectionTypeId int not null,
	FileCollectionTypeProfileName varchar(70),
	FileDestinationPath varchar(150) not null,
	FileNameTemplate varchar(150) not null,
	FileNameResolutionTypeId int,
	FileTypeId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EmailWhenReceived varchar(1000),
	FileToBeCollectedGroupId int,
	FundId int,
	EndDt datetime,
	LastActionUserID int)