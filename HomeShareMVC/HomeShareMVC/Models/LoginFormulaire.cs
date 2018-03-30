using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace HomeShareMVC.Models
{
    public class LoginFormulaire
    {
        [Required(ErrorMessage = "*Champs requis")]
        [StringLength(25)]
        public string login { get; set; }

        [Required(ErrorMessage = "*Champs requis")]
        [StringLength(25)]
        public string password { get; set; }
    }
}