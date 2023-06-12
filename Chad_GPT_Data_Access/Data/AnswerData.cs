using Chad_GPT_Data_Access.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chad_GPT_Data_Access.Data
{
    public class AnswerData : IAnswerData
    {
        private readonly ISqlDataAccess _db;
        public AnswerData(ISqlDataAccess db)
        {
            _db = db;
        }
        public async Task<IEnumerable<QuestionAnswer>> GetAnswers() =>
            await _db.LoadData<QuestionAnswer, dynamic>(
                storedProcedure: "dbo.GetAnswers",
                new { });

        public async Task<QuestionAnswer> GetAnswer(int id)
        {
            var results = await _db.LoadData<QuestionAnswer, dynamic>(
                storedProcedure: "dbo.GetAnswer", new { Id = id });
            return results.FirstOrDefault(x => x.Id == id);
        }

        public async Task InsertAnswer(QuestionAnswer answer) =>
            await _db.SaveData(storedProcedure: "dbo.InsertAnswer", new
            {
                Id = answer.Id,
                Prompt = answer.Prompt,
                Answer = answer.Answer,
                CategoryId = answer.CategoryId,
                CreatedBy = answer.CreatedBy,
                CreatedOn = DateTime.Now

            });
        public async Task DeleteAnswer(int id) =>
            await _db.SaveData(
                storedProcedure: "dbo.DeleteAnswer",
                new { Id = id });

    }
}
