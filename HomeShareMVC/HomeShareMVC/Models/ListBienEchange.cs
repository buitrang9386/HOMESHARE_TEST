using HomeShare.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HomeShareMVC.Models
{
    public class ListBienEchange
    {
        public BienEchange bienEchange { get; set; }
        public List<BienEchange> listBienEchange { get; set; }
        public ListBienEchange()
        {

        } 
    
    }
}