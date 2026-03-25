using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Helpers
{
    public class Convertidor
    {
        public static IModeloEntrada Clonar<IModeloEntrada>(IModeloEntrada elemento) where IModeloEntrada : class, new() => Convertidor.Convertir<IModeloEntrada, IModeloEntrada>(elemento);

        public static IModeloSalida Convertir<IModeloEntrada, IModeloSalida>(
            IModeloEntrada elementoBase,
            Action<IModeloEntrada, IModeloSalida> reglaTransformacion = null)
            where IModeloEntrada : class
            where IModeloSalida : new()
        {
            return Mapeador.MapearObjetos<IModeloEntrada, IModeloSalida>(elementoBase, reglaTransformacion);
        }

        public static IEnumerable<IModeloSalida> ConvertirLista<IModeloEntrada, IModeloSalida>(
            IEnumerable<IModeloEntrada> elementos,
            Action<IModeloEntrada, IModeloSalida> reglaTransformacion = null)
            where IModeloEntrada : class
            where IModeloSalida : new()
        {
            return (IEnumerable<IModeloSalida>)elementos.Select<IModeloEntrada, IModeloSalida>((Func<IModeloEntrada, IModeloSalida>)(elementoBase => Mapeador.MapearObjetos<IModeloEntrada, IModeloSalida>(elementoBase, reglaTransformacion))).ToList<IModeloSalida>();
        }


    }
}
