using Microsoft.AspNetCore.Mvc;

namespace Chad_GPT_SQL_MVC.Controllers
{
    public class AnswerController : Controller
    {
        private readonly IAnswerData _db;
        public AnswerController(IAnswerData db)
        {
            _db = db;
        }

        public async Task<IActionResult> Index()
        {
            var questions = await _db.GetAnswers();
            return View(questions);
        }
        public IActionResult AddAnswer()
        {
            return View(new QuestionAnswer());
        }
    }
}
