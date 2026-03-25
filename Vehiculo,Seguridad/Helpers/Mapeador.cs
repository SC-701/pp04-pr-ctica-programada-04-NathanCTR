using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Helpers
{
    public class Mapeador
    {
        public static IModeloSalida MapearObjetos<IModeloEntrada, IModeloSalida>(
            IModeloEntrada objOrigen,
            Action<IModeloEntrada, IModeloSalida> ReglaTransformacion = null)
            where IModeloEntrada : class
            where IModeloSalida : new()
        {
            Type type1 = typeof(IModeloEntrada);
            Type type2 = typeof(IModeloSalida);
            IModeloSalida destino = default(IModeloSalida);
            if ((object)objOrigen != null)
            {
                destino = (IModeloSalida)Activator.CreateInstance(type2);
                PropertyInfo[] properties1 = type1.GetProperties();
                PropertyInfo[] properties2 = type2.GetProperties();
                Mapeador.SincronizarObjetos<IModeloEntrada, IModeloSalida>(objOrigen, destino, properties1, properties2);
                if (ReglaTransformacion != null)
                    ReglaTransformacion(objOrigen, destino);
            
            }
            return destino;

        }

        public static void SincronizarObjetos<IModeloEntrada, IModeloSalida>(
            IModeloEntrada origen,
            IModeloSalida destino,
            PropertyInfo[] propiedadesOrigen,
            PropertyInfo[] propiedadesDestino)
        {
            foreach (PropertyInfo propertyInfo1 in propiedadesOrigen)
            {
                string nombrePropiedad = propertyInfo1.Name;
                PropertyInfo propertyInfo2 = ((IEnumerable<PropertyInfo>)propiedadesDestino).FirstOrDefault<PropertyInfo>((Func<PropertyInfo, bool>)(x => x.Name == nombrePropiedad));
                if (propertyInfo2 !=(PropertyInfo)null &&propertyInfo2.CanWrite && propertyInfo2.GetIndexParameters().Length == 0 && propertyInfo1.PropertyType.Name == propertyInfo2.PropertyType.Name)
                {
                        if ((propertyInfo2.PropertyType.IsClass ? 1 : (propertyInfo2.PropertyType.IsInterface ? 1 : 0)) == 0| propertyInfo2.PropertyType.Name.Equals("String") | propertyInfo2.PropertyType.Name.EndsWith("[]"))
                        {
                             object obj = propertyInfo1.GetValue((object)origen, (object[])null);
                             propertyInfo2.SetValue((object)destino, (object[])null);
                        }
                }



            }
        
        
        }

    }
}
