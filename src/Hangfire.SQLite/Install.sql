CREATE TABLE [Hangfire.Schema] (
        [Version]       integer NOT NULL

);
CREATE TABLE [Hangfire.Job] (
        [Id]    INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        [StateId]       integer,
        [StateName]     nvarchar(20) COLLATE NOCASE,
        [InvocationData]        nvarchar NOT NULL COLLATE NOCASE,
        [Arguments]     nvarchar NOT NULL COLLATE NOCASE,
        [CreatedAt]     datetime NOT NULL,
        [ExpireAt]      datetime

);
CREATE INDEX [Job_IX_HangFire_Job_ExpireAt]
ON [Hangfire.Job]
([ExpireAt] DESC);
CREATE INDEX [Job_IX_HangFire_Job_StateName]
ON [Hangfire.Job]
([StateName] DESC);
CREATE TABLE [Hangfire.State] (
        [Id]    integer NOT NULL,
        [JobId] integer NOT NULL,
        [Name]  nvarchar(20) NOT NULL COLLATE NOCASE,
        [Reason]        nvarchar(100) COLLATE NOCASE,
        [CreatedAt]     datetime NOT NULL,
        [Data]  nvarchar COLLATE NOCASE
,
    FOREIGN KEY ([JobId])
        REFERENCES [Hangfire.Job]([Id])
);
CREATE INDEX [State_IX_HangFire_State_JobId]
ON [Hangfire.State]
([JobId] DESC);
CREATE TABLE [Hangfire.JobParameter] (
        [Id]    INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        [JobId] integer NOT NULL,
        [Name]  nvarchar(40) NOT NULL COLLATE NOCASE,
        [Value] nvarchar COLLATE NOCASE
,
    FOREIGN KEY ([JobId])
        REFERENCES [Hangfire.Job]([Id])
);
CREATE INDEX [JobParameter_IX_HangFire_JobParameter_JobIdAndName]
ON [Hangfire.JobParameter]
([JobId] DESC, [Name] DESC);
CREATE TABLE [Hangfire.JobQueue] (
        [Id]    INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        [JobId] integer NOT NULL,
        [Queue] nvarchar(20) NOT NULL COLLATE NOCASE,
        [FetchedAt]     datetime

);
CREATE INDEX [JobQueue_IX_HangFire_JobQueue_QueueAndFetchedAt]
ON [Hangfire.JobQueue]
([Queue] DESC, [FetchedAt] DESC);
CREATE TABLE [Hangfire.Server] (
        [Id]    nvarchar(50) PRIMARY KEY NOT NULL COLLATE NOCASE,
        [Data]  nvarchar COLLATE NOCASE,
        [LastHeartbeat] datetime NOT NULL

);
CREATE TABLE [Hangfire.List] (
        [Id]    INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        [Key]   nvarchar(100) NOT NULL COLLATE NOCASE,
        [Value] nvarchar COLLATE NOCASE,
        [ExpireAt]      datetime

);
CREATE INDEX [List_IX_HangFire_List_ExpireAt]
ON [Hangfire.List]
([ExpireAt] DESC);
CREATE INDEX [List_IX_HangFire_List_Key]
ON [Hangfire.List]
([Key] DESC);
CREATE TABLE [Hangfire.Set] (
        [Id]    INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        [Key]   nvarchar(100) NOT NULL COLLATE NOCASE,
        [Score] float NOT NULL,
        [Value] nvarchar(256) NOT NULL COLLATE NOCASE,
        [ExpireAt]      datetime

);
CREATE INDEX [Set_IX_HangFire_Set_ExpireAt]
ON [Hangfire.Set]
([ExpireAt] DESC);
CREATE INDEX [Set_IX_HangFire_Set_Key]
ON [Hangfire.Set]
([Key] DESC);
CREATE UNIQUE INDEX [Set_UX_HangFire_Set_KeyAndValue]
ON [Hangfire.Set]
([Key] DESC, [Value] DESC);
CREATE TABLE [Hangfire.Counter] (
        [Id]    INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        [Key]   nvarchar(100) NOT NULL COLLATE NOCASE,
        [Value] smallint NOT NULL,
        [ExpireAt]      datetime

);
CREATE INDEX [Counter_IX_HangFire_Counter_Key]
ON [Hangfire.Counter]
([Key] DESC);
CREATE TABLE [Hangfire.Hash] (
        [Id]    INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        [Key]   nvarchar(100) NOT NULL COLLATE NOCASE,
        [Field] nvarchar(100) NOT NULL COLLATE NOCASE,
        [Value] nvarchar COLLATE NOCASE,
        [ExpireAt]      datetime COLLATE NOCASE

);
CREATE INDEX [Hash_IX_HangFire_Hash_ExpireAt]
ON [Hangfire.Hash]
([ExpireAt] DESC);
CREATE INDEX [Hash_IX_HangFire_Hash_Key]
ON [Hangfire.Hash]
([Key] DESC);
CREATE UNIQUE INDEX [Hash_UX_HangFire_Hash_Key_Field]
ON [Hangfire.Hash]
([Key] DESC, [Field] DESC);
CREATE TABLE [Hangfire.AggregatedCounter] (
        [Id]    INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        [Key]   nvarchar(100) NOT NULL COLLATE NOCASE,
        [Value] integer NOT NULL,
        [ExpireAt]      datetime

);
CREATE UNIQUE INDEX [AggregatedCounter_UX_HangFire_CounterAggregated_Key]
ON [Hangfire.AggregatedCounter]
([Key] DESC);
