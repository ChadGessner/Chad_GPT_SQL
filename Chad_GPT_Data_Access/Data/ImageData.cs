using Chad_GPT_Data_Access.Models;

namespace Chad_GPT_Data_Access.Data
{
    public class ImageData : IImageData
    {
        private readonly ISqlDataAccess _db;
        public ImageData(ISqlDataAccess db)
        {
            _db = db;
        }
        public async Task<IEnumerable<Image>> GetImages() =>
            await _db.LoadData<Image, dynamic>(
                storedProcedure: "dbo.GetImages", new { });
        public async Task<Image> GetImage(int id)
        {
            var results = await _db.LoadData<Image, dynamic>(
                storedProcedure: "dbo.GetImage", new { Id = id });
            return results.FirstOrDefault(x => x.Id == id);
        }
        public async Task InsertImage(Image image) =>
            await _db.SaveData(
                storedProcedure: "dbo.InsertImage", new
                {
                    Id = image.Id,
                    Prompt = image.Prompt,
                    URL = image.URL,
                    CategoryId = image.CategoryId
                });
        public async Task DeleteImage(int id) =>
            await _db.SaveData(
                storedProcedure: "dbo.DeleteImage",
                new { Id = id });
    }
}
