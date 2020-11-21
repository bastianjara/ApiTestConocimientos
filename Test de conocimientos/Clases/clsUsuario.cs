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
        /// <summary>
        /// Se agrega nuevo campo password para validacion de contraseñas y que estas sean iguales
        /// </summary>
        public string password_usuario_repita { get; set; }
        /// <summary>
        /// Campo requerido para saber el nombre del usuario a agregado
        /// </summary>
        [Required, MaxLength(200)]
        public string nombre_usuario { get; set; }

    }
    public class clsUsuario
    {
        /// <summary>
        /// Campo requerido para poder validar registro en bd e iniciar sesion
        /// </summary>
        [Required, MaxLength(100)]
        public string username_usuario { get; set; }
        /// <summary>
        /// Campo para validacion de contraseña
        /// </summary>
        [Required]
        public string password_usuario { get; set; }
        
    }

}