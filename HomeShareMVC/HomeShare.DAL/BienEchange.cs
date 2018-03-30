using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HomeShare.DAL
{
    public class BienEchange
    {
        /// <summary>
        /// propfull
        /// </summary>
        #region Prop
        private int _idBienEchange;

        public int IdBienEchange
        {
            get { return _idBienEchange; }
            set { _idBienEchange = value; }
        }

        private string _titre;

        public string Titre
        {
            get { return _titre; }
            set { _titre = value; }
        }

        private string _descCourte;

        public string DescCourte
        {
            get { return _descCourte; }
            set { _descCourte = value; }
        }
        private string _descLong;

        public string DescLong
        {
            get { return _descLong; }
            set { _descLong = value; }
        }

        private int _nombrePerson;

        public int NombrePerson
        {
            get { return _nombrePerson; }
            set { _nombrePerson = value; }
        }

        private int _pays;

        public int Pays
        {
            get { return _pays; }
            set { _pays = value; }
        }

        private string _ville;

        public string Ville
        {
            get { return _ville; }
            set { _ville = value; }
        }

        private string _rue;

        public string Rue
        {
            get { return _rue; }
            set { _rue = value; }
        }

        private string _numero;

        public string Numero
        {
            get { return _numero; }
            set { _numero = value; }
        }

        private string _codePostal;

        public string CodePostal
        {
            get { return _codePostal; }
            set { _codePostal = value; }
        }

        private string _photo;

        public string Photo
        {
            get { return _photo; }
            set { _photo = value; }
        }

        private bool _assuranceObligatoire;

        public bool AssuranceObligatoire
        {
            get { return _assuranceObligatoire; }
            set { _assuranceObligatoire = value; }
        }

        private bool _isEnabled;

        public bool IsEnabled
        {
            get { return _isEnabled; }
            set { _isEnabled = value; }
        }

        private DateTime? _disabledDate;

        public DateTime? DisableDate
        {
            get { return _disabledDate; }
            set { _disabledDate = value; }
        }
        private string _latitude;

        public string Latitude
        {
            get { return _latitude; }
            set { _latitude = value; }
        }

        private string _longitude;

        public string Longitude
        {
            get { return _longitude; }
            set { _longitude = value; }
        }

        private int _idMembre;

        public int IdMembre
        {
            get { return _idMembre; }
            set { _idMembre = value; }
        }

        private DateTime _dateCreation;

        public DateTime DateCreation
        {
            get { return _dateCreation; }
            set { _dateCreation = value; }
        } 
        #endregion

        /// <summary>
        /// Constructor
        /// </summary>
        public BienEchange()
        {

        }
        public BienEchange(int idBienEchange, string titre, string descCourte, string descLong, int nombrePerson,
            int pays, string ville, string rue, string numero, string codePostal, string photo)
        {
            IdBienEchange = idBienEchange;
            Titre = titre;
            DescCourte = descCourte;
            DescLong = descLong;
            NombrePerson = nombrePerson;
            Pays = pays;
            Ville = ville;
            Rue = rue;
            Numero = numero;
            CodePostal = codePostal;
            Photo = photo;
           
        }
        public BienEchange(int idBienEchange, string titre, string descCourte, string descLong, int nombrePerson,
           int pays, string ville, string rue, string numero, string codePostal, string photo,
           bool assuranceObligatoire, bool isEnabled, DateTime? disableDate)
        {
            IdBienEchange = idBienEchange;
            Titre = titre;
            DescCourte = descCourte;
            DescLong = descLong;
            NombrePerson = nombrePerson;
            Pays = pays;
            Ville = ville;
            Rue = rue;
            Numero = numero;
            CodePostal = codePostal;
            Photo = photo;
            AssuranceObligatoire = assuranceObligatoire;
            IsEnabled = isEnabled;
            DisableDate = disableDate;

        }

        public BienEchange(int idBienEchange, string titre, string descCourte, string descLong, int nombrePerson, 
            int pays, string ville, string rue, string numero, string codePostal, string photo, bool assuranceObligatoire, 
            bool isEnabled, DateTime? disableDate, string latitude, string longitude, int idMembre, DateTime dateCreation)
        {
            IdBienEchange = idBienEchange;
            Titre = titre;
            DescCourte = descCourte;
            DescLong = descLong;
            NombrePerson = nombrePerson;
            Pays = pays;
            Ville = ville;
            Rue = rue;
            Numero = numero;
            CodePostal = codePostal;
            Photo = photo;
            AssuranceObligatoire = assuranceObligatoire;
            IsEnabled = isEnabled;
            DisableDate = disableDate;
            Latitude = latitude;
            Longitude = longitude;
            IdMembre = idMembre;
            DateCreation = dateCreation; 
        }

      
                 
                  
                  
                   
                  
                  
                   
               
                  
               
                   
            















    }
}
