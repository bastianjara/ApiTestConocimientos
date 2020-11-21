using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Test_de_conocimientos.Clases
{
    /// <summary>
    /// Clase global 
    /// </summary>
    public class clsTarea
    {
        /// <summary>
        /// id de la tarea desde base de datos al momento de listar y actualizar
        /// </summary>
        public int id_tarea { get; set; }

    }
    /// <summary>
    /// Clase que hereda la global
    /// </summary>
    public class clsDatosTarea
    {
        /// <summary>
        /// Nombre de la tarea requerido ya que no puede existir tarea sin nombre
        /// </summary>
        [Required, MaxLength(100)]
        public string nombre_tarea { get; set; }
        /// <summary>
        /// Estado de la tarea (No Resuelto / Resuelto)
        /// </summary>
        [MaxLength(30)]
        public string estado_tarea { get; set; }
        /// <summary>
        /// Descripcion es un campo requerido ya que nos indicara de que trata la tarea a mostrar y/o actualiza en la bd
        /// </summary>
        /// 
        [Required, MaxLength(300)]
        public string descripcion_tarea { get; set; }

    }
}