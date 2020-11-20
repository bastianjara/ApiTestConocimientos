using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Test_de_conocimientos.Clases
{
    /// <summary>
    /// Clase usuario
    /// </summary>
    public class clsDatosUsuario : clsUsuario
    {

        public string password_usuario_repita { get; set; }
        [Required, MaxLength(200)]
        public string nombre_usuario { get; set; }

    }
    public class clsUsuario
    {
        [Required, MaxLength(100)]
        public string username_usuario { get; set; }
        [Required]
        public string password_usuario { get; set; }
        
    }

}