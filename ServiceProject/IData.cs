using Microsoft.AspNetCore.Mvc;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataApi
{
    public interface IData
    {
        Task<ActionResult<IEnumerable<Product>>> ProductsGet();
        Task<ActionResult<IEnumerable<Product>>> ProductsGet(string name);
        Task<ActionResult<Product>> ProductAdd(Product product);
        Task<ActionResult<Product>> ProductChenge(Product product);
        Task<ActionResult<bool>> ProductDelete(Guid id);
        //-------------------

        Task<ActionResult<IEnumerable<Model.ProductVersion>>> ProductVersionsGet();
        Task<ActionResult<IEnumerable<Model.ProductVersion>>> ProductVersionsGet(Guid productID);
        Task<ActionResult<Model.ProductVersion>> ProductVersionAdd(ProductVersion productVersion);
        Task<ActionResult<Model.ProductVersion>> ProductVersionChenge(ProductVersion productVersion);
        Task<ActionResult<bool>> ProductVertionDelete(Guid id);

        //------------------------

        Task<ActionResult<IEnumerable<EventLog>>> EventLogGet();
    }
}
