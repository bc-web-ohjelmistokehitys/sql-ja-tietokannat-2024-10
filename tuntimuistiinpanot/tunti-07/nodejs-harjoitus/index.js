import pg from "pg";
import Fastify from "fastify";

const { Client } = pg;

const client = new Client({
  connectionString: "postgres://localhost/suomioy",
});

const muuttuja = "5";

console.log("hellurei");
await client.connect();

// Import the framework and instantiate it

const fastify = Fastify({
  logger: true,
});

// Declare a route
fastify.get("/", async function handler(request, reply) {
  // array literal
  const array = [];

  // JSON.

  // object literal
  return { hello: "world" };
});

fastify.get("/person", async (req, res) => {
  // TODO: validointi
  // TODO: virheenhallinta
  const page = req.query.page;

  const ret = await client.query(
    "SELECT * FROM person ORDER BY id ASC LIMIT 100 OFFSET $1",
    [(page - 1) * 100]
  );
  return ret.rows;
});

fastify.delete("/person/:id", async (req, res) => {
  const id = req.params.id;

  const ret = await client.query(`DELETE FROM person WHERE id = $1`, [id]);

  return res.code(410).send({ gone: "with the wind" });
});

fastify.get("/person/:id", async (req, res) => {
  const id = req.params.id;

  console.log("id", id);

  const ret = await client.query(`SELECT * FROM person WHERE id = $1`, [id]);

  if (ret.rows.length === 0) {
    return res.status(404).send({ error: "Not found" });
  }

  return ret.rows[0];
});

// Run the server!
try {
  await fastify.listen({ port: 3000 });
} catch (err) {
  fastify.log.error(err);
  process.exit(1);
}

/*
const ret = await client.query("SELECT * FROM person LIMIT 10");

console.log("ROWS", ret.rows);

console.log("hellurei2");

await client.end();
*/
