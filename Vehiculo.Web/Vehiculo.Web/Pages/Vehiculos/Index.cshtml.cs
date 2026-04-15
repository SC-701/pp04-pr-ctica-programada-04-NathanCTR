using Abstracciones.Interfaces.Reglas;
using Abstracciones.Modelos;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Net;
using System.Runtime.Intrinsics.Arm;
using System.Text.Json;

namespace Web.Pages.Vehiculos
{
    [Authorize]
    public class IndexModel : PageModel
    {
        private IConfiguracion _configuracion;
        public IList<VehiculoResponse> vehiculos { get; set; }=default!;
        public IndexModel(IConfiguracion configuracion)
        {
            _configuracion = configuracion;
        }

        public async Task OnGet()
        {
            
            string endpoint = _configuracion.ObtenerMetodo("ApiEndPoints", "ObtenerVehiculos");
            using var cliente = ObtenerClienteConToken();
            cliente.BaseAddress = new Uri(urlBase);
            var respuesta = await cliente.GetAsync(metodo);
            var solicitud = new HttpRequestMessage(HttpMethod.Get, endpoint);
            respuesta.EnsureSuccessStatusCode();
            if (respuesta.StatusCode == HttpStatusCode.OK)
            {
                var resultado=await respuesta.Content.ReadAsStringAsync();
                var opciones=new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
                vehiculos = JsonSerializer.Deserialize<List<VehiculoResponse>>(resultado, opciones);
            }
        }

        private HttpClient ObtenerClienteConToken()
        {
            var tokenClaim = HttpContext.User.Claims
                .FirstOrDefault(c => c.Type == "AccessToken");
            var cliente = new HttpClient();
            if (tokenClaim != null)
                cliente.DefaultRequestHeaders.Authorization =
                    new System.Net.Http.Headers.AuthenticationHeaderValue(
                        "Bearer", tokenClaim.Value);
            return cliente;
        }
    }
}
