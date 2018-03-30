using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HomeShare.DAL
{
    public class Membre
    {
        /// <summary>
        /// propfull
        /// </summary>
        #region Propfull
        private int _idMembre;

        public int IdMembre
        {
            get { return _idMembre; }
            set { _idMembre = value; }
        }
        private string _nom;

        public string Nom
        {
            get { return _nom; }
            set { _nom = value; }
        }

        private string _prenom;

        public string Prenom
        {
            get { return _prenom; }
            set { _prenom = value; }
        }

        private string _email;

        public string Email
        {
            get { return _email; }
            set { _email = value; }
        }

        private int _pays;

        public int Pays
        {
            get { return _pays; }
            set { _pays = value; }
        }

        private string _telephone;

        public string Telephone
        {
            get { return _telephone; }
            set { _telephone = value; }
        }

        private string _login;

        public string Login
        {
            get { return _login; }
            set { _login = value; }
        }

        private string _password;

        public string Password
        {
            get { return _password; }
            set { _password = value; }
        }

        private string _photoUser;

        public string PhotoUser
        {
            get { return _photoUser; }
            set { _photoUser = value; }
        }

        private bool _isDeleted;

        public bool IsDeleted
        {
            get { return _isDeleted; }
            set { _isDeleted = value; }
        }
        #endregion

        /// <summary>
        /// Constructor
        /// </summary>
        #region Ctor
        public Membre()
        {

        }
        public Membre(string nom, string prenom, string email, int pays, string telephone,
            string login, string password, string photoUser, bool isDeleted)
        {           
            Nom = nom;
            Prenom = prenom;
            Email = email;
            Pays = pays;
            Telephone = telephone;
            Login = login;
            Password = password;
            PhotoUser = photoUser;
            IsDeleted = isDeleted;
        }
        public Membre(int idMembre, string nom, string prenom, string email, int pays, string telephone,
            string login, string password, string photoUser, bool isDeleted) 
            : this(nom, prenom, email, pays, telephone, login, password, photoUser, isDeleted)
        {
            IdMembre = idMembre;
            Nom = nom;
            Prenom = prenom;
            Email = email;
            Pays = pays;
            Telephone = telephone;
            Login = login;
            Password = password;
            PhotoUser = photoUser;
            IsDeleted = isDeleted;
        }

        #endregion










    }
}
