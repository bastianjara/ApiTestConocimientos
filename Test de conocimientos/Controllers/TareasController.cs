using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Test_de_conocimientos.Models;
using Test_de_conocimientos.Clases;
using System.Data;

namespace Test_de_conocimientos.Controllers
{
    public class TareasController : ApiController
    {
        agilesoftEntities a = new agilesoftEntities();
        /// <summary>
        /// Metodo para listar las tareas existentes
        /// </summary>
        /// <returns></returns>
        [Route("ListaTareas")]
        public IHttpActionResult ListaTareas()
        {
            try
            {
                var res = a.sp_lista_tareas().ToList();
                if (res.Count() > 0)
                {
                    return Ok(res);
                }
                else {
                    return Ok("No existen regitros");
                }

                
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        /// <summary>
        /// Metodo para insertar una tarea nueva
        /// </summary>
        /// <param name="tarea"></param>
        /// <returns></returns>
        [Route("InsertaTarea")]        
        public IHttpActionResult InsertaTarea(clsDatosTarea tarea)
        {
            try
            {
                if (tarea.nombre_tarea !="" && tarea.estado_tarea !="" && tarea.descripcion_tarea != "")
                {
                    if (tarea.estado_tarea == "No Resuelto" || tarea.estado_tarea == "Resuelto")
                    {
                        var res = a.sp_inserta_tarea(tarea.nombre_tarea, tarea.estado_tarea, tarea.descripcion_tarea).ToList()[0];

                        return Ok(res[0]);
                    }
                    else
                    {
                        return Ok("Estado no aceptado");
                    }
                }
                else
                {
                     return Ok("Favor completar los campos");
                }

                
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        /// <summary>
        /// Metodo para actualizar tarea y dejar en estado resuelto
        /// </summary>
        /// <param name="id_tarea"></param>
        /// <returns></returns>
        [Route("ActualizaTarea")]
        public IHttpActionResult ActualizaTarea(clsTarea tarea)
        {
            try
            {
                if (tarea.id_tarea != 0  )
                {
                    var res = a.sp_actualiza_tarea(tarea.id_tarea).ToList()[0];
                    return Ok(res);
                }
                else
                {
                    return Ok("Favor completar los campos");
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

    }
}
