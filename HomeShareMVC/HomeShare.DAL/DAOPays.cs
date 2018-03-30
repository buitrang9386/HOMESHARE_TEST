using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HomeShare.DAL
{
    public class DAOPays : DAO, IDAO<Pays>
    {
        public Pays create(Pays obj)
        {
            throw new NotImplementedException();
        }

        public void delete(int id)
        {
            throw new NotImplementedException();
        }

        public Pays read(int id)
        {
            throw new NotImplementedException();
        }

        public List<Pays> readAll()
        {
            SqlCommand cmd = connection.CreateCommand();
            string query = "SELECT * FROM Pays";
            cmd.CommandText = query;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            DataTable dt = new DataTable();
            da.Fill(dt);
            List<Pays> listPays = new List<Pays>(); 
            foreach (DataRow row in dt.Rows)
            {
                Pays unPays = new Pays(
                    (int)row["idPays"],
                    row["Libelle"].ToString(),
                    row["Photo"].ToString());
                listPays.Add(unPays); 
            }
            return listPays; 
        }

        public Pays update(Pays obj)
        {
            throw new NotImplementedException();
        }
    }
}
