using Chad_GPT_Data_Access.Models;
using System.Linq;
namespace Chad_GPT_Data_Access.Data
{
    public class UserData : IUserData
    {
        private readonly ISqlDataAccess _db;
        public UserData(ISqlDataAccess db)
        {
            _db = db;
        }

        public async Task<IEnumerable<User>> GetUsers() => 
           await _db.LoadData<User, dynamic>(
                storedProcedure: "dbo.GetUsers",
                new { });

        public async Task<User> GetUser(int id)
        {
            var results = await _db.LoadData<User, dynamic>(
                storedProcedure: "dbo.GetUser",
                new { Id = id });
            foreach(var user in results)
            {
                Console.WriteLine(user.Id);
            }
            return results.FirstOrDefault(x=>x.Id==id) ?? new User();
        }
        public async Task<User> UserLogin(string username, string password)
        {
            var results = await _db.LoadData<User, dynamic>(
                storedProcedure: "dbo.GetUserByUsernameAndPassword", new
                {

                    UserName = username,
                    Password = password
                });
            return results
                .FirstOrDefault(x=>x.UserName==username&&x.Password == password);
        }
            
            
                
        public async Task<User> InsertUser(User user) 
        {
            _db.SaveData(storedProcedure: "dbo.InsertUser", new
            {
                UserName = user.UserName,
                Password = user.Password
            });
            var results = await _db.LoadData<User, dynamic>(
                storedProcedure: "dbo.GetUserByUsernameAndPassword", new { 
                    
                    UserName = user.UserName, 
                    Password = user.Password });
            return results
                .FirstOrDefault(
                x => x.UserName == user.UserName && x.Password == user.Password);
        }
            
        public async Task UpdateUser(User user) =>
           await _db.SaveData(
                storedProcedure: "dbo.UpdateUser",
                new
                {
                    Id = user.Id,
                    UserName = user.UserName,
                    Password = user.Password
                });
        public async Task DeleteUser(int id) =>
            await _db.SaveData(
                storedProcedure: "dbo.DeleteUser",
                new { Id = id });
    }
}
