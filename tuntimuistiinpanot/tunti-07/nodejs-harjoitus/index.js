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
  return { hello: "world" };
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
