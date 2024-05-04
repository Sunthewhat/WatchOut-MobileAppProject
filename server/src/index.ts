import { Hono } from "hono";
//hi
const app = new Hono();

app.get("/", (c) => {
  return c.text("Hello!");
});

export default app;
