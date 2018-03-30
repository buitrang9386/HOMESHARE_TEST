using HomeShare.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HomeShareMVC.infas
{
    public class SessionUtils
    {
        public static Membre MembreConnected
        {
            get
            {
                if (HttpContext.Current.Session["MembreConnected"] == null)
                    HttpContext.Current.Session["MembreConnected"] = default(Membre);
                return (Membre)HttpContext.Current.Session["MembreConnected"];
            }

            set { HttpContext.Current.Session["MembreConnected"] = value; }
        }
    }
}