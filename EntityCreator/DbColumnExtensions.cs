public static class DbColumnExtensions
{
    public static bool IsInsertDate(this DbColumn c)
        => c.Name == "InsertDate";

    public static bool IsUpdateDate(this DbColumn c)
        => c.Name == "UpdateDate";

    public static bool IsIsActive(this DbColumn c)
        => c.Name == "IsActive";
}
