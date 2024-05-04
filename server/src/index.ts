import { Hono } from 'hono';
import { config } from 'dotenv';

config();

const app = new Hono();

app.get('/', (c) => {
	return c.text('Hello!');
});

if (Bun.env.ENV_VALIDATION != 'true') {
	throw new Error('No .env file found');
}
export default {
	port: Bun.env.PORT || 8000,
	fetch: app.fetch,
};
