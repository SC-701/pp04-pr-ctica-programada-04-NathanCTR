using Abstracciones.API;
using Abstracciones.Flujo;
using Abstracciones.Modelos;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class AutenticacionController : Controller, IAutorizacionController
    {
        private IAutenticacionBW _autenticacionFlujo;

        public AutenticacionController(IAutenticacionBW autenticacionFlujo)
        {
            _autenticacionFlujo = autenticacionFlujo;
        }

        [AllowAnonymous]
        [HttpPost("login")]
        public async Task<IActionResult> PostAsync([FromBody] LoginBase login)
        {
            return Ok(await _autenticacionFlujo.LoginAsync(login));
        }
    }
}
