using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chad_GPT_Data_Access.Models
{
    public class Image
    {
        public int Id { get; set; }
        public string Prompt { get; set; }
        public string URL { get; set; }
        public int CategoryId { get; set; }
    }
}
