import { Hono } from 'hono';
import { logger } from 'hono/logger';
import { config } from 'dotenv';
import ValidateENV from './services/validateENV';
import auth from './routes/auth.routes';
import { cors } from 'hono/cors';
import { PrismaClient } from '@prisma/client';

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

export default {
	port: Bun.env.PORT || 8000,
	fetch: app.fetch,
};
