using Chad_GPT_Data_Access.Models;

namespace Chad_GPT_Data_Access.Data
{
    public interface IAnswerData
    {
        Task DeleteAnswer(int id);
        Task<QuestionAnswer> GetAnswer(int id);
        Task<IEnumerable<QuestionAnswer>> GetAnswers();
        Task InsertAnswer(QuestionAnswer answer);
    }
}