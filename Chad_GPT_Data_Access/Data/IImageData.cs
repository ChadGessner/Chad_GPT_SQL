using Chad_GPT_Data_Access.Models;

namespace Chad_GPT_Data_Access.Data
{
    public interface IImageData
    {
        Task DeleteImage(int id);
        Task<Image> GetImage(int id);
        Task<IEnumerable<Image>> GetImages();
        Task InsertImage(Image image);
    }
}