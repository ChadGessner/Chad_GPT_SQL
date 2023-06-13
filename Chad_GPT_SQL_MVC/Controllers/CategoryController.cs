
using Microsoft.AspNetCore.Mvc;

namespace Chad_GPT_SQL_MVC.Controllers
{
    public class CategoryController : Controller
    {
        private readonly ICategoryData _db;
        public CategoryController(ICategoryData db)
        {
            _db = db;
        }

        public async Task<IActionResult> Index()
        {
            var categories = await _db.GetCategories();
            return View(categories);
        }
        [HttpGet]
        public IActionResult AddCategory()
        {
            return View(new Category());
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AddCategory(IFormCollection collection)
        {
            Console.WriteLine(
                "Stuff followed by error message" + "   " + collection["categoryName"]);
            Console.WriteLine("Stuff followed by error message" + "   " + collection["type"]);
            await _db.InsertCategory(
                new() 
                { 
                    CategoryName = collection["categoryName"], 
                    Type = int.Parse(collection["type"])});
            return RedirectToAction(nameof(Index));
        }
        #region for api endpoints
        [HttpGet]
        public async Task<IEnumerable<Category>> GetCategoriesAsync() => await _db.GetCategories();
        

        #endregion
    }
}
