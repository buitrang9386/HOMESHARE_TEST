using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HomeShare.DAL
{
    public class Pays
    {
        
        #region Propfull
        private int _idPays;

        public int IdPays
        {
            get { return _idPays; }
            set { _idPays = value; }
        }

        private string _libelle;

        public string Libelle
        {
            get { return _libelle; }
            set { _libelle = value; }
        }

        private string _photo;

        public string Photo
        {
            get { return _photo; }
            set { _photo = value; }
        }


        #endregion
        #region Constructor
        public Pays()
        {

        }
        public Pays(int idPays, string libelle, string photo)
        {
            IdPays = idPays;
            Libelle = libelle;
            Photo = photo; 
        }
        #endregion

    }
}
