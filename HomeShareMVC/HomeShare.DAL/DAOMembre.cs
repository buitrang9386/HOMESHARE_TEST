using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HomeShare.DAL
{
    public class DAOMembre : DAO, IDAO<Membre>
    {
        public Membre create(Membre obj)
        {
            SqlCommand cmd = connection.CreateCommand();
            string query = "INSERT INTO Membre (Nom, Prenom, Email, Pays, Telephone, Login, Password, PhotoUser, IsDeleted) " +
                "OUTPUT inserted.idMembre " +
                "VALUES (@nom, @prenom, @email, @pays, @telephone, @login, @password, @photoUser, @isDeleted)";
            cmd.CommandText = query;
            cmd.Parameters.AddWithValue("@nom", obj.Nom);
            cmd.Parameters.AddWithValue("@prenom", obj.Prenom);
            cmd.Parameters.AddWithValue("@email", obj.Email);
            cmd.Parameters.AddWithValue("@pays", obj.Pays);
            cmd.Parameters.AddWithValue("@telephone", obj.Telephone);
            cmd.Parameters.AddWithValue("@login", obj.Login);
            cmd.Parameters.AddWithValue("@password", obj.Password);
            cmd.Parameters.AddWithValue("@photoUser", (obj.PhotoUser==null)? (object)DBNull.Value: obj.PhotoUser);
            cmd.Parameters.AddWithValue("@isDeleted", obj.IsDeleted);
            connection.Open();
            int idMembre = (int)cmd.ExecuteScalar();
            connection.Close();
            return obj; 
        }

        public void delete(int id)
        {
            throw new NotImplementedException();
        }

        public Membre read(int id)
        {
            throw new NotImplementedException();
        }

        public List<Membre> readAll()
        {
            throw new NotImplementedException();
        }

        public Membre update(Membre obj)
        {
            throw new NotImplementedException();
        }
        public Membre Connection (string login, string password)
        {
            SqlCommand command = connection.CreateCommand();
            string query = "SELECT * FROM Membre WHERE Login = @login AND Password = @password ";
            command.CommandText = query;
            command.Parameters.AddWithValue("@login", login);
            command.Parameters.AddWithValue("@password", password);
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = command;
            DataTable dt = new DataTable();
            da.Fill(dt);
            Membre unMembre = null; 
            foreach (DataRow row in dt.Rows)
            {
                unMembre = new Membre(
                    (int)row["idMembre"],
                    row["Nom"].ToString(),
                    row["Prenom"].ToString(),
                    row["Email"].ToString(),
                    (int)row["Pays"],
                    row["Telephone"].ToString(),
                    row["login"].ToString(),
                    row["password"].ToString(),
                    row["PhotoUser"].ToString(),
                    (bool)row["isDeleted"]); 
            }
            return unMembre;
        }
    }
}
