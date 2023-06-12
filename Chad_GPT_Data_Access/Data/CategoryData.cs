using Chad_GPT_Data_Access.Models;

namespace Chad_GPT_Data_Access.Data
{
    public class CategoryData : ICategoryData
    {
        private readonly ISqlDataAccess _db;
        public CategoryData(ISqlDataAccess db)
        {
            _db = db;
        }
        public async Task<IEnumerable<Category>> GetCategories() => await
            _db.LoadData<Category, dynamic>(
                storedProcedure: "dbo.GetCategories", new { });
        public async Task<Category> GetCategory(int id)
        {
            var results = await _db.LoadData<Category, dynamic>(
                storedProcedure: "dbo.GetCategory", new { Id = id });
            return results.FirstOrDefault(x => x.Id == id);
        }

        public async Task InsertCategory(Category cat) =>
            await _db.SaveData(
                storedProcedure: "dbo.InsertCategory", new
                {
                    
                    CategoryName = cat.CategoryName,
                    Type = cat.Type
                });
    }
}
