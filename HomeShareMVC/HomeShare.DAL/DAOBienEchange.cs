using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HomeShare.DAL
{
    public class DAOBienEchange : DAO, IDAO<BienEchange>
    {
        public BienEchange create(BienEchange obj)
        {
            throw new NotImplementedException();
        }

        public void delete(int id)
        {
            throw new NotImplementedException();
        }

        public BienEchange read(int id)
        {
            throw new NotImplementedException();
        }
        public List<BienEchange> readByMembre(int idMembre)
        {
            SqlCommand cmd = connection.CreateCommand();
            string query = "SELECT * FROM BienEchange WHERE idMembre = @idMembre";
            cmd.CommandText = query;
            cmd.Parameters.AddWithValue("@idMembre", idMembre);
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            DataTable dt = new DataTable();
            da.Fill(dt);
            BienEchange bienEchange = null;
            List<BienEchange> listBienEchange = new List<BienEchange>();           
            foreach (DataRow row in dt.Rows)
            {
                bienEchange = new BienEchange(
                     (int)row["idBien"],
                   row["titre"].ToString(),
                   row["DescCourte"].ToString(),
                   row["DescLong"].ToString(),
                   (int)row["NombrePerson"],
                   (int)row["Pays"],
                   row["Ville"].ToString(),
                   row["Rue"].ToString(),
                   row["Numero"].ToString(),
                   row["CodePostal"].ToString(),
                   row["Photo"].ToString(),
                   // //Convert.ToBoolean(row["AssuranceObligatoire"]),
                   (bool)row["AssuranceObligatoire"],
                   ////row.Field<bool?>("AssuranceObligatoire")??false,
                   // // Convert.ToBoolean(row["isEnabled"]),
                   (bool)row["isEnabled"],
                   row.Field<DateTime?>("DisabledDate"),
                   //(DateTime?)row["DisabledDate"]
                   row["Latitude"].ToString(),
                   row["Longitude"].ToString(),
                   (int)row["idMembre"],
                   (DateTime)row["DateCreation"]
                   );
                listBienEchange.Add(bienEchange); 
            }
            return listBienEchange; 
        }

        public List<BienEchange> readAll()
        {
            throw new NotImplementedException();
        }

        public BienEchange update(BienEchange obj)
        {
            throw new NotImplementedException();
        }
    }
}
