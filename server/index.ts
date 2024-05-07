import { Hono } from 'hono';
import { logger } from 'hono/logger';
import { config } from 'dotenv';
import ValidateENV from './services/validateENV';
import auth from './routes/auth.routes';

config();
ValidateENV();

const app = new Hono({ strict: false });

app.use(logger());
app.get('/', (c) => c.text('Hello!'));

app.route('/auth', auth);

export default {
	port: Bun.env.PORT || 8000,
	fetch: app.fetch,
};
