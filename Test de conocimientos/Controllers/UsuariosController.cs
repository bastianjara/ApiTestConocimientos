using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using RouteAttribute = System.Web.Http.RouteAttribute;
using Test_de_conocimientos.Clases;
using Test_de_conocimientos.Models;
namespace Test_de_conocimientos.Controllers
{
    public class UsuariosController : ApiController
    {
        agilesoftEntities a = new agilesoftEntities();


        /// <summary>
        /// Metodo para insertar usuarios via post
        /// </summary>
        /// <param name="usuario">
        /// Metodo post la creacion de usuarios via post reicibiendo el username, passweord y nombre
        /// </param>
        /// <returns></returns>
        [Route("CrearUsuario")]
        public IHttpActionResult CrearUsuario(clsDatosUsuario usuario)
        {
            try
            {
                if (usuario.password_usuario == usuario.password_usuario_repita && (usuario.nombre_usuario != "" && usuario.username_usuario != ""))
                {
                    var res = a.pa_inserta_usuario(usuario.username_usuario, usuario.password_usuario, usuario.nombre_usuario).ToList()[0] ;
                    return Ok(res);
                }
                else if (usuario.password_usuario != usuario.password_usuario_repita)
                {
                    return Ok("Las contraseñas no coinciden");
                }
                else {
                    return Ok("Favor Completar los datos");
                }

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        /// <summary>
        /// Metodo para inciar sesion 
        /// </summary>
        /// <param name="usuario">
        /// Este metodo recibe como datos de entrada el username y la password para validar si este existe en la base de datos
        /// </param>
        /// <returns></returns>
        [Route("IniciarSesion")]
        public IHttpActionResult IniciarSesion(clsUsuario usuario)
        {
            try
            {
                if (usuario.username_usuario !="" && usuario.password_usuario!="")
                {
                    var res = a.pa_iniciar_sesion(usuario.username_usuario, usuario.password_usuario).ToList();
                    if (res.Count()>0)
                    {
                        return Ok(res[0]);
                    }
                    else
                    {
                        return Ok("Usuario no encontrado");
                    }
                    
                }
                else
                {
                    return Ok("Favor Completar los datos");
                }
            }
            catch (Exception ex)
            {

                return BadRequest(ex.Message);
            }
        }


    }
}
