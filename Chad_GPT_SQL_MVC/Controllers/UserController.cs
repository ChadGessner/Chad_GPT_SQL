using Chad_GPT_SQL_MVC.Models;
using Microsoft.AspNetCore.Mvc;

using System.Diagnostics;
using System.Web;
using System.Security;
using Microsoft.AspNetCore.Authentication;

namespace Chad_GPT_SQL_MVC.Controllers
{
    public class UserController : Controller
    {
        private readonly IUserData _db;
        private readonly IUserLoginStore<User> login;
        public UserController(IUserData db)
        {
            _db = db;
        }
        
        
        public async Task<IActionResult> Index()
        {
            return View(await GetUsersAsync());
        }
        public IActionResult Login()
        {
            return View(new User());
        }
        public IActionResult Logout()
        {
            if (HttpContext.Request.Cookies.ContainsKey("loginCookie"))
            {
               // HttpContext.Response.Cookies.Clear();

                HttpContext.Response.Cookies.Delete("loginCookie");
            }
            return RedirectToAction(nameof(Login));
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(string userName, string password)
        {
            var model = await _db.UserLogin(userName, password);
            if (HttpContext.Request.Cookies.ContainsKey("loginCookie"))
            {
                HttpContext.Response.Cookies.Delete("loginCookie");
            }
            if (model != null)
            {

                var cookie = HttpContext.Request.Cookies["loginCookie"];

                HttpContext.Response.Cookies.Append("loginCookie", model.UserName);
                return RedirectToAction(nameof(PostLogin), model);
            }
            return View(userName, password);
        }
        public IActionResult PostLogin(User user)
        {
            return View(user);
        }
        public IActionResult Register()
        {
            return View(new User());
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Register(string userName, string password)
        {
            Console.WriteLine(userName);
            Console.WriteLine(password);
            var model = await _db.InsertUser(new User()
            {
                UserName = userName,
                Password = password
            });
            
            if(model != null)
            {
                Console.WriteLine("NOT NULL");
                return RedirectToAction(nameof(PostLogin), model);
            }
            return View(userName, password);
        }
        #region for API endpoints
        public async Task<JsonResult> GetUser(string userName, string password)
        {
            var model = await _db.UserLogin(userName, password);
            var json = new {Id = model.Id, UserName = model.UserName, Password = model.Password};
            Console.WriteLine(json);
            return Json(json);
        }
        public async Task<IEnumerable<UserViewModel>> GetUsersAsync()
        {
            var users = await _db.GetUsers();
            return users.Select(x=> UserViewModel.GetUserViewModelFromDTO(x));
        }
            #endregion
    }
}
