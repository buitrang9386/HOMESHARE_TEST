using HomeShare.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HomeShareMVC.Models; 
using System.Web.Mvc;

namespace HomeShareMVC.Controllers
{
    public class HomeController : Controller
    {
        #region DAO
        DAOPays dAOPays = new DAOPays();
        DAOMembre dAOMembre = new DAOMembre(); 
        #endregion
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
        [HttpGet]
        public ActionResult ajouterUnMembre()
        {
            ajouterMembreModel membreModel = new ajouterMembreModel();
            membreModel.listPays = dAOPays.readAll(); 
            return View(membreModel); 
        }
        [HttpPost]
        public ActionResult ajouterUnMembre(string Nom, string Prenom, string Email, int Pays, 
            string Telephone, string Login, string Password)
        {
            Membre unMembre = new Membre(Nom, Prenom, Email, Pays, Telephone, Login, Password, null, false);            
            dAOMembre.create(unMembre);
            return RedirectToAction("Connection", "User");
        }
    }
}