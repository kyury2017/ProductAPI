using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Interfaces
{
    public interface IProducts
    {
        /// <summary>
        /// Получает все объекты Product из БД
        /// </summary>
        /// <returns></returns>
        IList<Models.Product> GetProducts();
        /// <summary>
        /// Возвращает объекты Product по фрагменту названия
        /// </summary>
        /// <param name="name">фрагмент названия</param>
        /// <returns></returns>
        IList<Models.Product> GetProducts(string name);
        /// <summary>
        /// Изменяет Product с заданым id
        /// </summary>
        /// <param name="id"></param>
        /// <param name="product"></param>
        Models.Product ChangeProduct(Guid id, Models.Product product);
        /// <summary>
        /// Создает новый объект Product
        /// </summary>
        /// <param name="product"></param>
        /// <returns></returns>
        Models.Product AddProduct(Models.Product product);
        /// <summary>
        /// Удаляюеи объект product с заданным идентификатором
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        bool DeleteProduct(Guid id);
    }
}
