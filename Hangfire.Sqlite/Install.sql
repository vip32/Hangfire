CREATE TABLE [Schema] (
        [Version]       integer NOT NULL

);
CREATE TABLE [Job] (
        [Id]    integer NOT NULL,
        [StateId]       integer,
        [StateName]     nvarchar(20) COLLATE NOCASE,
        [InvocationData]        nvarchar NOT NULL COLLATE NOCASE,
        [Arguments]     nvarchar NOT NULL COLLATE NOCASE,
        [CreatedAt]     datetime NOT NULL,
        [ExpireAt]      datetime

);
CREATE INDEX [Job_IX_HangFire_Job_ExpireAt]
ON [Job]
([ExpireAt] DESC);
CREATE INDEX [Job_IX_HangFire_Job_StateName]
ON [Job]
([StateName] DESC);
CREATE TABLE [State] (
        [Id]    integer NOT NULL,
        [JobId] integer NOT NULL,
        [Name]  nvarchar(20) NOT NULL COLLATE NOCASE,
        [Reason]        nvarchar(100) COLLATE NOCASE,
        [CreatedAt]     datetime NOT NULL,
        [Data]  nvarchar COLLATE NOCASE
,
    FOREIGN KEY ([JobId])
        REFERENCES [Job]([Id])
);
CREATE INDEX [State_IX_HangFire_State_JobId]
ON [State]
([JobId] DESC);
CREATE TABLE [JobParameter] (
        [Id]    integer NOT NULL,
        [JobId] integer NOT NULL,
        [Name]  nvarchar(40) NOT NULL COLLATE NOCASE,
        [Value] nvarchar COLLATE NOCASE
,
    FOREIGN KEY ([JobId])
        REFERENCES [Job]([Id])
);
CREATE INDEX [JobParameter_IX_HangFire_JobParameter_JobIdAndName]
ON [JobParameter]
([JobId] DESC, [Name] DESC);
CREATE TABLE [JobQueue] (
        [Id]    integer NOT NULL,
        [JobId] integer NOT NULL,
        [Queue] nvarchar(20) NOT NULL COLLATE NOCASE,
        [FetchedAt]     datetime

);
CREATE INDEX [JobQueue_IX_HangFire_JobQueue_QueueAndFetchedAt]
ON [JobQueue]
([Queue] DESC, [FetchedAt] DESC);
CREATE TABLE [Server] (
        [Id]    nvarchar(50) NOT NULL COLLATE NOCASE,
        [Data]  nvarchar COLLATE NOCASE,
        [LastHeartbeat] datetime NOT NULL

);
CREATE TABLE [List] (
        [Id]    integer NOT NULL,
        [Key]   nvarchar(100) NOT NULL COLLATE NOCASE,
        [Value] nvarchar COLLATE NOCASE,
        [ExpireAt]      datetime

);
CREATE INDEX [List_IX_HangFire_List_ExpireAt]
ON [List]
([ExpireAt] DESC);
CREATE INDEX [List_IX_HangFire_List_Key]
ON [List]
([Key] DESC);
CREATE TABLE [Set] (
        [Id]    integer NOT NULL,
        [Key]   nvarchar(100) NOT NULL COLLATE NOCASE,
        [Score] float NOT NULL,
        [Value] nvarchar(256) NOT NULL COLLATE NOCASE,
        [ExpireAt]      datetime

);
CREATE INDEX [Set_IX_HangFire_Set_ExpireAt]
ON [Set]
([ExpireAt] DESC);
CREATE INDEX [Set_IX_HangFire_Set_Key]
ON [Set]
([Key] DESC);
CREATE UNIQUE INDEX [Set_UX_HangFire_Set_KeyAndValue]
ON [Set]
([Key] DESC, [Value] DESC);
CREATE TABLE [Counter] (
        [Id]    integer NOT NULL,
        [Key]   nvarchar(100) NOT NULL COLLATE NOCASE,
        [Value] smallint NOT NULL,
        [ExpireAt]      datetime

);
CREATE INDEX [Counter_IX_HangFire_Counter_Key]
ON [Counter]
([Key] DESC);
CREATE TABLE [Hash] (
        [Id]    integer NOT NULL,
        [Key]   nvarchar(100) NOT NULL COLLATE NOCASE,
        [Field] nvarchar(100) NOT NULL COLLATE NOCASE,
        [Value] nvarchar COLLATE NOCASE,
        [ExpireAt]      datetime COLLATE NOCASE

);
CREATE INDEX [Hash_IX_HangFire_Hash_ExpireAt]
ON [Hash]
([ExpireAt] DESC);
CREATE INDEX [Hash_IX_HangFire_Hash_Key]
ON [Hash]
([Key] DESC);
CREATE UNIQUE INDEX [Hash_UX_HangFire_Hash_Key_Field]
ON [Hash]
([Key] DESC, [Field] DESC);
CREATE TABLE [AggregatedCounter] (
        [Id]    integer NOT NULL,
        [Key]   nvarchar(100) NOT NULL COLLATE NOCASE,
        [Value] integer NOT NULL,
        [ExpireAt]      datetime

);
CREATE UNIQUE INDEX [AggregatedCounter_UX_HangFire_CounterAggregated_Key]
ON [AggregatedCounter]
([Key] DESC);
