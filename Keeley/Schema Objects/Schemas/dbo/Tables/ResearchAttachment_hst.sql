USE Keeley

create table DBO.ResearchAttachment_hst(
	ResearchAttachmentId int not null,
	ResearchId int not null,
	FileName varchar(500) not null,
	FileExtensionTypeId int not null,
	CodeRedId uniqueidentifier,
	Document varbinary not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)