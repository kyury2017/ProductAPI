using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class ProductVersion:Base
    {
        public Guid ProductID { get; set; }
        public DateTime CreatingDate { get; set; } = DateTime.Now;
        public uint Width { get; set; }
        public uint Height { get; set; }
        public uint Length { get; set; }
        public string Name { get; set; } = string.Empty;
    }
}
