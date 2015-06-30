// This file is part of Hangfire.
// Copyright © 2013-2014 Sergey Odinokov.
// 
// Hangfire is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as 
// published by the Free Software Foundation, either version 3 
// of the License, or any later version.
// 
// Hangfire is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public 
// License along with Hangfire. If not, see <http://www.gnu.org/licenses/>.

using System;
using System.Data;
using Hangfire.SqlServer;

namespace Hangfire.SQLite
{
    internal class SQLiteJobQueueProvider : IPersistentJobQueueProvider
    {
        private readonly SQLiteStorageOptions _options;

        public SQLiteJobQueueProvider(SQLiteStorageOptions options)
        {
            if (options == null) throw new ArgumentNullException("options");

            _options = options;
        }

        public SQLiteStorageOptions Options { get { return _options; } }

        public IPersistentJobQueue GetJobQueue(IDbConnection connection)
        {
            return new SQLiteJobQueue(connection, _options);
        }

        public IPersistentJobQueueMonitoringApi GetJobQueueMonitoringApi(IDbConnection connection)
        {
            return new SQLiteJobQueueMonitoringApi(connection);
        }
    }
}