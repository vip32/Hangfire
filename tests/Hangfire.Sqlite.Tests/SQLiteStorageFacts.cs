using System;
using System.Linq;
using System.Transactions;
using Hangfire.SQLite.Tests.Utils;
using Xunit;

namespace Hangfire.SQLite.Tests
{
    public class SQLiteStorageFacts
    {
        private readonly SQLiteStorageOptions _options;

        public SQLiteStorageFacts()
        {
            _options = new SQLiteStorageOptions { PrepareSchemaIfNecessary = false };
        }

        [Fact]
        public void Ctor_ThrowsAnException_WhenConnectionStringIsNull()
        {
            var exception = Assert.Throws<ArgumentNullException>(
                () => new SQLiteStorage((string)null));

            Assert.Equal("nameOrConnectionString", exception.ParamName);
        }

        [Fact]
        public void Ctor_ThrowsAnException_WhenOptionsValueIsNull()
        {
            var exception = Assert.Throws<ArgumentNullException>(
                () => new SQLiteStorage("hello", null));

            Assert.Equal("options", exception.ParamName);
        }

        [Fact, CleanDatabase]
        public void Ctor_CanCreateSqlServerStorage_WithExistingConnection()
        {
            var connection = ConnectionUtils.CreateConnection();
            var storage = new SQLiteStorage(connection);

            Assert.NotNull(storage);
        }

        [Fact, CleanDatabase]
        public void Ctor_InitializesDefaultJobQueueProvider_AndPassesCorrectOptions()
        {
            var storage = CreateStorage();
            var providers = storage.QueueProviders;

            var provider = (SQLiteJobQueueProvider)providers.GetProvider("default");

            Assert.Same(_options, provider.Options);
        }

        [Fact, CleanDatabase]
        public void GetConnection_ReturnsExistingConnection_WhenStorageUsesIt()
        {
            var connection = ConnectionUtils.CreateConnection();
            var storage = new SQLiteStorage(connection);

            using (var storageConnection = (SQLiteConnection)storage.GetConnection())
            {
                Assert.Same(connection, storageConnection.Connection);
                Assert.False(storageConnection.OwnsConnection);
            }
        }

        [Fact, CleanDatabase(IsolationLevel.ReadUncommitted)]
        public void GetMonitoringApi_ReturnsNonNullInstance()
        {
            var storage = CreateStorage();
            var api = storage.GetMonitoringApi();
            Assert.NotNull(api);
        }

        [Fact, CleanDatabase]
        public void GetConnection_ReturnsNonNullInstance()
        {
            var storage = CreateStorage();
            using (var connection = (SQLiteConnection)storage.GetConnection())
            {
                Assert.NotNull(connection);
                Assert.True(connection.OwnsConnection);
            }
        }

        [Fact, CleanDatabase]
        public void GetComponents_ReturnsAllNeededComponents()
        {
            var storage = CreateStorage();

            var components = storage.GetComponents();

            var componentTypes = components.Select(x => x.GetType()).ToArray();
            Assert.Contains(typeof(ExpirationManager), componentTypes);
        }

        private SQLiteStorage CreateStorage()
        {
            return new SQLiteStorage(
                ConnectionUtils.GetConnectionString(), _options);
        }
    }
}
