const st = new Date().getTime();
import { Hono } from 'hono';
import { logger } from 'hono/logger';
import { config } from 'dotenv';
import ValidateENV from './services/validateENV';
import auth from './routes/auth.routes';
import { cors } from 'hono/cors';
import { PrismaClient } from './prisma/client';
import image from './routes/image.routes';
import report from './routes/report.routes';

config();
ValidateENV();

const app = new Hono({ strict: false });
export const prisma = new PrismaClient();

app.use(
	cors({
		origin: '*',
	})
);
app.use(logger());
app.get('/', (c) =>
	c.json({
		success: true,
		payload: null,
		message: 'Welcome to Hono',
	})
);

app.route('/auth', auth);
app.route('/image', image);
app.route('/report', report);

const en = new Date().getTime();

console.log(`${en - st} ms to start the server`);
export default {
	port: Bun.env.PORT || 8000,
	fetch: app.fetch,
};
