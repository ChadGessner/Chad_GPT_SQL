using Microsoft.AspNetCore.Authentication.Cookies;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddSingleton<IUserData, UserData>();
builder.Services.AddSingleton<ISqlDataAccess, SqlDataAccess>();
builder.Services.AddSingleton<ICategoryData, CategoryData>();
builder.Services.AddSingleton<IAnswerData, AnswerData>();
//this is a .NET Interface/Class for getting cookies and shiz I guess....
builder.Services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();

//#################


builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options=> 
    {
        options.LoginPath = "/User/PostLogin/";
        options.AccessDeniedPath = "/User/Forbidden";
    });
builder.Services.ConfigureApplicationCookie(options =>
{
    options.LoginPath = $"/User/Login/"; 
    //options.LogoutPath = $"";
    //options.AccessDeniedPath = $"";
});
var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

//app.UseRouting();
//app.UseCookiePolicy();
app.UseAuthorization();
app.UseAuthentication();
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
