using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chad_GPT_Data_Access.Models
{
    public class User
    {
        public int Id { get; set; } 
        public string UserName { get; set; }
        public string Password { get; set; }    
    }
}
