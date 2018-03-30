using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HomeShare.DAL
{
    public class DAOOption : DAO, IDAO<Options>
    {
        public Options create(Options obj)
        {
            throw new NotImplementedException();
        }

        public void delete(int id)
        {
            throw new NotImplementedException();
        }

        public Options read(int id)
        {
            throw new NotImplementedException();
        }
        public Options readByBien(int idBien)
        {
            throw new NotImplementedException();
        }

        public List<Options> readAll()
        {
            SqlCommand cmd = connection.CreateCommand();
            string query = "SELECT * FROM Options";
            cmd.CommandText = query;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            DataTable dt = new DataTable();
            da.Fill(dt);
            List<Options> listOptions = new List<Options>();
            foreach (DataRow row in dt.Rows)
            {
                Options unOption = new Options(
                    (int)row["idOption"],
                    row["Libelle"].ToString());
                listOptions.Add(unOption);
            }
            return listOptions;
        }    

        public Options update(Options obj)
        {
            throw new NotImplementedException();
        }
    }
}
