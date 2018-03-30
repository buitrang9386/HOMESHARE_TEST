using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HomeShare.DAL
{
    public class DAO
    {
        private const string connectionString
           = @"Data Source=DESKTOP-SG5JCS0\MSSQLSERVER2;Initial Catalog=HomeShareDB;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=True;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
        protected SqlConnection connection
            = new SqlConnection(connectionString);
        public DAO()
        {

        }

        private SqlConnection getSqlConnection()
        {
            return connection;
        }
    }
}
