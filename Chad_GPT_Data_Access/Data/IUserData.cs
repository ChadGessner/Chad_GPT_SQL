using Chad_GPT_Data_Access.Models;

namespace Chad_GPT_Data_Access.Data
{
    public interface IUserData
    {
        Task<User> UserLogin(string username, string password);
        Task DeleteUser(int id);
        Task<User> GetUser(int id);
        Task<IEnumerable<User>> GetUsers();
        Task<User> InsertUser(User user);
        Task UpdateUser(User user);
    }
}