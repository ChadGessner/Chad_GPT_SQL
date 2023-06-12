namespace Chad_GPT_SQL_MVC.Models
{
    public class UserViewModel
    {
        public string UserName { get; set; }
        public string Password { get; set; }

        public static UserViewModel GetUserViewModelFromDTO(User user)
        {
            return new UserViewModel()
            {
                UserName = user.UserName,
                Password = user.Password,
            };
        }
    }
}
