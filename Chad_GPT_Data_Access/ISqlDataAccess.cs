namespace Chad_GPT_Data_Access
{
    public interface ISqlDataAccess
    {
        Task<IEnumerable<T>> LoadData<T, U>(
            string storedProcedure, 
            U parameters, 
            string connectionId = "StringyConnections");
        Task SaveData<T>(
            string storedProcedure, 
            T parameters, 
            string connectionId = "StringyConnections");
    }
}