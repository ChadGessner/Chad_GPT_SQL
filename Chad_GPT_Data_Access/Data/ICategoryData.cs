using Chad_GPT_Data_Access.Models;

namespace Chad_GPT_Data_Access.Data
{
    public interface ICategoryData
    {
        Task<IEnumerable<Category>> GetCategories();
        Task<Category> GetCategory(int id);
        Task InsertCategory(Category cat);
    }
}