using HomeShare.DAL;
using HomeShareMVC.infas;
using HomeShareMVC.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HomeShareMVC.Controllers
{
    public class UserController : Controller
    {
        #region DAO
        DAOMembre daoMembre = new DAOMembre();
        DAOBienEchange daoBienEchange = new DAOBienEchange();
        DAOPays dAOPays = new DAOPays(); 
        #endregion

        // GET: User
        public ActionResult Index()
        {

            return View();
        }
        [HttpGet]
        public ActionResult Connection()
        {
            LoginFormulaire loginFormulaire = new LoginFormulaire(); 
            return View(loginFormulaire);
        }
        [HttpPost]
        public ActionResult Connection(string login, string password)
        {
            Membre unMembre = daoMembre.Connection(login, password);
            SessionUtils.MembreConnected = unMembre;
            return RedirectToAction("Index", "User");
        }

        public ActionResult DeConnection()
        {
            SessionUtils.MembreConnected = null;                     
            return RedirectToAction("Index", "Home");
        }
        [HttpGet]
        public ActionResult afficherBiens()
        {
            Models.ListBienEchange list = new ListBienEchange(); 
            //List<BienEchange> listiBienEchange = daoBienEchange.readByMembre(SessionUtils.MembreConnected.IdMembre);
            list.listBienEchange= daoBienEchange.readByMembre(SessionUtils.MembreConnected.IdMembre);
            return View(list);
        }
        public ActionResult ajouterBiens()
        {
            ajouterUnBien bienModel = new ajouterUnBien();
            bienModel.listPays = dAOPays.readAll();
            return View(); 
        }
    }
}