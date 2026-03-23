using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Abstracciones.Modelos
{
    public class VehiculoBase
    {
        [Required(ErrorMessage = "La propiedad Placa es requerida")]
        [RegularExpression(@"[A-Za-z]{3}-[0-9]{3}", ErrorMessage = "El formato deL Placa debe ser ###/ABC")]
        public string Placa { get; set;}

        [Required(ErrorMessage = "La propiedad Color es requerida")]
        [RegularExpression(@"[A-Za-z]{3}-[0-9]{3}", ErrorMessage = "El formato de la Color debe ser ###/ABC")]
        public string Color { get; set; }

        [Required(ErrorMessage = "La propiedad Anio es requerida")]
        [RegularExpression(@"(19|20)\d\d", ErrorMessage = "El formato del Anio no es valido")]
        public int Anio { get; set; }
        [Required(ErrorMessage = "La propiedad Precio es requerida")]
        public decimal Precio { get; set; }
        [Required(ErrorMessage = "La propiedad Correo es requerida")]
        [EmailAddress]
        public string CorreoPropietario { get; set; }
        [Required(ErrorMessage = "La propiedad Telefono es requerida")]
        [Phone]
        public string TelefonoPropietario { get; set; }
    }

    public class VehiculoRequest : VehiculoBase
    {
        public Guid IdModelo { get; set; }


    }

    public class VehiculoDetalle : VehiculoResponse
    {
        public bool RevisionValida { get; set; }

        public bool RegistroValido { get; set; }
    }

    public class VehiculoResponse : VehiculoBase
    {
        public Guid Id { get; set; }

        public string Modelo { get; set; }

        public string Marca { get; set; }
    }
}
