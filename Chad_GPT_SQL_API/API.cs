using Chad_GPT_Data_Access.Data;
using Chad_GPT_Data_Access.Models;
using Microsoft.AspNetCore.Identity;

namespace Chad_GPT_SQL_API
{
    public static class API
    {
        public static void ConfigureApi(this WebApplication app) 
        {
            app.MapGet("/Users", GetUsers);
            app.MapGet("/Users/{id}", GetUser);
            app.MapGet("/Answers", GetAnswers);
            app.MapGet("/Answers/{id}", GetAnswer);
            app.MapGet("/Category", GetCategories);
            app.MapPost("/Users", AddUser);
            app.MapDelete("/Users", DeleteUser);
        }
        private static async Task<IResult> GetCategories(ICategoryData data)
        {
            try
            {
                return Results.Ok(await data.GetCategories());
            }
            catch (Exception ex)
            {

                return Results.Problem(ex.Message);
            }
        }
        private static async Task<IResult> GetAnswers(IAnswerData data)
        {
            try
            {
                return Results.Ok(await data.GetAnswers());
            }
            catch (Exception ex)
            {

                return Results.Problem(ex.Message);
            }
        }
        private static async Task<IResult> GetAnswer(int id, IAnswerData data)
        {
            try
            {
                return Results.Ok(await data.GetAnswer(id));
            }
            catch (Exception ex)
            {

                return Results.Problem(ex.Message);
            }
        }
        private static async Task<IResult> GetUsers(IUserData data)
        {
            try
            {
                return Results.Ok(await data.GetUsers());
            }
            catch (Exception ex)
            {

                return Results.Problem(ex.Message);
            }
        }
        private static async Task<IResult> GetUser(int id, IUserData data)
        {
            try
            {
                return Results.Ok(await data.GetUser(id));
            }
            catch (Exception ex)
            {

                return Results.Problem(ex.Message);
            }
        }
        private static async Task<IResult> AddUser(User user, IUserData data)
        {
            try
            {
                return Results.Ok(await data.InsertUser(user));
            }
            catch ( Exception ex)
            {

                return Results.Problem(ex.Message);
            }
        }
        private static async Task<IResult> DeleteUser(int userId, IUserData data)
        {
            try
            {
                await data.DeleteUser(userId);
                return Results.Ok();
            }
            catch (Exception ex)
            {

                return Results.Problem(ex.Message);
            }
        }
    }
}
