
CREATE TABLE [dbo].[EntityType](
	[EntityTypeID] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [EntityTypePK] PRIMARY KEY,
	[Name] [varchar](100) NOT NULL,
	[StartDt] [datetime] NOT NULL,
	[UpdateUserID] [int] NOT NULL  CONSTRAINT EntityTypeUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	[DataVersion] [timestamp] NOT NULL)

create unique index [EntityTypeUK] on [EntityType](Name)

create table DBO.EntityProperty (
	EntityPropertyID int identity(1,1) not null CONSTRAINT EntityPropertyPK PRIMARY KEY,
	EntityTypeId int not null  CONSTRAINT EntityPropertyEntityTypeIDFK FOREIGN KEY REFERENCES EntityType(EntityTypeId),
	NeedsToBeCalculated bit not null,
	PropertyOnChildEntity bit not null,
	TypeCode int not null,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT EntityPropertyUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	

create unique index EntityPropertyUK on EntityProperty(EntityTypeId,Name)


create table DBO.ExtractType (
	ExtractTypeID int identity(1,1) not null CONSTRAINT ExtractTypePK PRIMARY KEY,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractTypeUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)

create unique index ExtractTypeUK on ExtractType(Name)

create table DBO.ExtractOutputType (
	ExtractOutputTypeID int identity(1,1) not null CONSTRAINT ExtractOutputTypePK PRIMARY KEY,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractOutputTypeUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)
create unique index ExtractOutputTypeUK on ExtractOutputType(Name)

create table DBO.Extract (
	ExtractID int identity(1,1) not null CONSTRAINT ExtractPK PRIMARY KEY,
	ExtractTypeId int not null  CONSTRAINT ExtractExtractTypeIdFK FOREIGN KEY REFERENCES ExtractType(ExtractTypeId),
	Name varchar(70) not null, 
	ExtractOutputTypeID  int not null  CONSTRAINT ExtractExtractOutputTypeIDFK FOREIGN KEY REFERENCES ExtractOutputType(ExtractOutputTypeID),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	
create unique index ExtractUK on ExtractType(Name)

create table DBO.ExtractConfiguration (
	ExtracttConfigurationID int identity(1,1) not null CONSTRAINT ExtractConfigurationPK PRIMARY KEY,
	ExtractId int not null  CONSTRAINT ExtractConfigurationExtractIdFK FOREIGN KEY REFERENCES Extract(ExtractId),
	ConfigurationKey varchar(100) not null,
	ConfigurationValue varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractConfigurationIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	
create unique index ExtractConfigurationUK on ExtractConfiguration(ExtractId,ConfigurationKey)

create table DBO.ExtractInputConfiguration(
	ExtractFieldConfigurationID int identity(1,1) not null CONSTRAINT ExtractFieldConfigurationPK PRIMARY KEY,
	ExtractId int not null  CONSTRAINT ExtractInputConfigurationExtractIdFK FOREIGN KEY REFERENCES Extract(ExtractId),
	EntityPropertyId int not null  CONSTRAINT ExtractInputConfigurationEntityPropertyIdFK FOREIGN KEY REFERENCES EntityProperty(EntityPropertyId),
	IntValue int ,
	StringValue varchar(1000) ,
	DecimalValue numeric(27,8),
	DateTimeValue DateTime ,
	BitValue bit ,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractFieldConfigurationUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
) 

create unique index ExtractInputConfigurationUK on ExtractInputConfiguration(ExtractId,EntityPropertyId,IntValue,StringValue,DecimalValue,DateTimeValue,BitValue)

create table DBO.ExtractRun (
	ExtractRunId int identity(1,1) not null CONSTRAINT ExtractRunPk PRIMARY KEY,
	ExtractId int not null  CONSTRAINT ExtractRunExtractIdFK FOREIGN KEY REFERENCES Extract(ExtractId),
	RunTime DateTime not null,
	InProgress bit not null,
	NumberRecords int not null,
	FilePath varchar(100),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractRunUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	

create unique index ExtractRunUK on ExtractRun(ExtractId,RunTime)

drop table DBO.ExtractOutputConfiguration
create table DBO.ExtractOutputConfiguration(
	ExtractOutputConfigurationID int identity(1,1) not null CONSTRAINT ExtractOutputConfigurationPK PRIMARY KEY,
	ExtractId int not null  CONSTRAINT ExtractFieldOutputConfigurationExtractIdFK FOREIGN KEY REFERENCES Extract(ExtractId),
	EntityPropertyId int not null CONSTRAINT ExtractOutputConfigurationDependantEntityPropertyIdFK FOREIGN KEY REFERENCES EntityProperty(EntityPropertyId),
	EntityPropertyToWriteId int not null CONSTRAINT ExtractOutputConfigurationPrincipalEntityPropertyIdFK FOREIGN KEY REFERENCES EntityProperty(EntityPropertyId),		
	Label varchar(1000),
	ChangesCanBeIgnored bit not null,
	OrderBy int not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractFieldOutputConfigurationUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
) 

select * from ExtractOutputConfiguration

create unique index ExtractOutputConfigurationUK on ExtractOutputConfiguration(ExtractId,EntityPropertyId,EntityPropertyIdToWrite)
create unique index ExtractOutputConfigurationUK2 on ExtractOutputConfiguration(ExtractId,Orderby)

create table DBO.ExtractEntity(
	ExtractEntityID int identity(1,1) not null CONSTRAINT ExtractEntityPK PRIMARY KEY,
	ExtractId int not null CONSTRAINT ExtractEntityExtractIdFK FOREIGN KEY REFERENCES Extract(ExtractId),
	EntityId int not null,
	EntityTypeId int not null CONSTRAINT ExtractEntityEntityTypeIdFK FOREIGN KEY REFERENCES EntityType(EntityTypeId),
	LastSentInExtractRunId int CONSTRAINT ExtractEntityLastSentInExtractRunIdFK FOREIGN KEY REFERENCES ExtractRun(ExtractRunId),
	IsCancelled bit not null,
	SendInNextRun bit not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractEntityUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)
	
create unique index ExtractEntityUK on ExtractEntity(ExtractId,EntityTypeId,EntityId)	
		
create table DBO.ExtractEntityPropertyValue(
	ExtractEntityPropertyValueID  int identity(1,1) not null CONSTRAINT ExtractEntityPropertyValuePK PRIMARY KEY,
	ExtractEntityID int not null  CONSTRAINT ExtractEntityPropertyValueExtractEntityIDFK FOREIGN KEY REFERENCES ExtractEntity(ExtractEntityID),	
	EntityPropertyId int not null  CONSTRAINT ExtractEntityPropertyValueEntityPropertyIdFK FOREIGN KEY REFERENCES EntityProperty(EntityPropertyId),
	PreviousIntValue int ,
	IntValue int ,
	StringValue varchar(1000) ,
	PreviousStringValue varchar(1000) ,
	DecimalValue numeric(27,8),
	PreviousDecimalValue numeric(27,8),
	DateTimeValue DateTime ,
	PreviousDateTimeValue DateTime ,
	BitValue bit ,
	PreviousBitValue bit ,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractEntityPropertyValueUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
) 

create unique index ExtractEntityPropertyValueUK on ExtractEntityPropertyValue(ExtractEntityID,EntityPropertyId)	

select * from EventType

INSERT INTO [Keeley].[dbo].[EntityType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Trade Event',GETDATE(),1)
INSERT INTO [Keeley].[dbo].[EntityType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Instrument Event',GETDATE(),1)
INSERT INTO [Keeley].[dbo].[EntityType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Capital Event',GETDATE(),1)           
INSERT INTO [Keeley].[dbo].[EntityType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('FX Trade Event',GETDATE(),1)           
INSERT INTO [Keeley].[dbo].[EntityType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Internal Accounting Event',GETDATE(),1)           
select * from [EntityType]
INSERT INTO [Keeley].[dbo].[ExtractType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Event Extract',GETDATE(),1) 
           
create table DBO.ExtractOutputType (
	ExtractOutputTypeID int identity(1,1) not null CONSTRAINT ExtractOutputTypePK PRIMARY KEY,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractOutputTypeUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)

create table DBO.ExtractOutputContainer (
	ExtractOutputTypeID int identity(1,1) not null CONSTRAINT ExtractOutputContainerPK PRIMARY KEY,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractOutputContainerUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)

create table DBO.ExtractDeliveryMechanism (
	ExtractOutputTypeID int identity(1,1) not null CONSTRAINT ExtractOutputContainerPK PRIMARY KEY,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractOutputContainerUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)

select * from ExtractOutputConfiguration      

INSERT INTO [Keeley].[dbo].[ExtractOutputType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Email With Generic CSV File',GETDATE(),1)

select * from LegalEntity where LegalEntityID in (select legalentityId from Counterparty)

update [ExtractConfiguration] set ConfigurationValue = 'CAC_{0:yyyyMMddHHmmss}.csv'
where ExtracttConfigurationId = 2

INSERT INTO [Keeley].[dbo].[ExtractConfiguration]
           ([ExtractId],[ConfigurationKey],[ConfigurationValue],[StartDt],[UpdateUserID])
     VALUES
           (1,'OutputFileNameFormat','CAC_{0:yyyyMMddHHmmss}.csv',GETDATE(),1)



INSERT INTO [Keeley].[dbo].[ExtractConfiguration]
           ([ExtractId],[ConfigurationKey],[ConfigurationValue],[StartDt],[UpdateUserID])
     VALUES
           (1,'OutputFileNameValue','DateTime.Now',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[ExtractConfiguration]
           ([ExtractId],[ConfigurationKey],[ConfigurationValue],[StartDt],[UpdateUserID])
     VALUES
           (1,'OutputDirectory','c:\temp',GETDATE(),1)
GO

private const string OutputFileNameFormatKey = "OutputFileNameFormat";
        private const string OutputFileNameValueKey = "OutputFileNameValue";
        private const string OutputDirectoryKey = "OutputDirectory"
        
update EntityProperty set Name = 'IsoCode' where EntityPropertyId = 29        

select * from ExtractEntity where EntityTypeId =9

select * from ExtractInputConfiguration