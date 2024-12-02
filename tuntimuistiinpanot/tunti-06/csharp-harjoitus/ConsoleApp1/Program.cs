using Npgsql;

var connectionString = "Host=localhost;Database=suomioy";

await using var dataSource = NpgsqlDataSource.Create(connectionString);

// Insert some data
/*
await using (var cmd = dataSource.CreateCommand("INSERT INTO data (some_field) VALUES ($1)"))
{
    cmd.Parameters.AddWithValue("Hello world");
    await cmd.ExecuteNonQueryAsync();
}
*/

// Retrieve all rows

try {

    var personId = "1";

    await using var cmd = dataSource.CreateCommand("SELECT last_name FROM person WHERE id = @id LIMIT 1");
    // cmd.Parameters.AddWithValue("$1", personId);

    cmd.Parameters.Add("@id", NpgsqlTypes.NpgsqlDbType.Integer).Value = int.Parse(personId);

    await using var reader = await cmd.ExecuteReaderAsync();
    while (await reader.ReadAsync())
    {
        Console.WriteLine(reader.GetString(0));
    }

} catch (PostgresException e) {

    Console.WriteLine("OH NOES KAUHEA VIRHE");
    
    Console.WriteLine(e.ToString());
} finally {
    Console.WriteLine("Minut ajetaan vaikka mitä tapahtuisi");
}

