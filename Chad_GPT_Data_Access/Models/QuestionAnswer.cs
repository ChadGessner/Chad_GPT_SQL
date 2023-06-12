using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chad_GPT_Data_Access.Models
{
    public class QuestionAnswer
    {
        public int Id { get; set; }
        public string Prompt { get; set; }
        public string Answer { get; set; }
        public int CategoryId { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }

    }
}
