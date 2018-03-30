using HomeShare.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HomeShareMVC.Models
{
    public class ajouterUnBien
    {
        public List<Pays> listPays { get; set; }
        public BienEchange unBienEchange { get; set; }
    }
}