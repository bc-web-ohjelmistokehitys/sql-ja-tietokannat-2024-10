import pg from "pg";

const { Client } = pg;

const client = new Client({
  connectionString: "postgres://localhost/suomioy",
});

const muuttuja: number = 5;

console.log("hellurei");
await client.connect();

const ret = await client.query("SELECT * FROM person LIMIT 10");

console.log("ROWS", ret.rows);

console.log("hellurei2");

await client.end();
