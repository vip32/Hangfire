using System;
using System.Data;
using System.IO;

namespace Hangfire.SQLite.Tests.Utils
{
    public static class ConnectionUtils
    {
        private const string DatabaseVariable = "Hangfire_SQLiteDatabaseName";
        private const string ConnectionStringTemplateVariable = "Hangfire_SQLite_ConnectionStringTemplate";
        private static readonly string DefaultDatabaseName = Path.Combine(Environment.CurrentDirectory, "Hangfire.SQLite.Tests.sqlite");
        private const string DefaultConnectionStringTemplate = @"Data Source={0}";

        public static string GetDatabaseName()
        {
            return Environment.GetEnvironmentVariable(DatabaseVariable) ?? DefaultDatabaseName;
        }

        public static string GetConnectionString()
        {
            return String.Format(GetConnectionStringTemplate(), GetDatabaseName());
        }

        private static string GetConnectionStringTemplate()
        {
            return Environment.GetEnvironmentVariable(ConnectionStringTemplateVariable)
                   ?? DefaultConnectionStringTemplate;
        }

        public static IDbConnection CreateConnection()
        {
            var connection = new System.Data.SQLite.SQLiteConnection(GetConnectionString());
            connection.Open();

            return connection;
        }
    }
}
