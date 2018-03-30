using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HomeShare.DAL
{
    public class Options
    {
        #region Propfull
        private int _idOption;

        public int IdOption
        {
            get { return _idOption; }
            set { _idOption = value; }
        }

        private string _libelle;

        public string Libelle
        {
            get { return _libelle; }
            set { _libelle = value; }
        }

        #endregion
    }
}
