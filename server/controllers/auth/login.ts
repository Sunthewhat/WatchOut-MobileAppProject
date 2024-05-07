import { Context } from 'hono';
import { compareSync } from 'bcrypt';
import GetUser from '../../services/auth/getUser';
import * as jwt from 'jsonwebtoken';

const Login = async (c: Context) => {
	const { username, password } = await c.req.json();
	if (!username || !password) {
		return c.json({ message: 'Missing required fields' }, 400);
	}
	const user = await GetUser(username);
	if (!user) return c.json({ message: 'User not found' }, 404);
	if (!compareSync(password, user.password))
		return c.json({ message: 'Invalid password' }, 401);

	const secret = Bun.env.JWT_SECRET;
	if (!secret) throw new Error('No JWT secret found in .env');
	const token = jwt.sign({ id: user.id }, secret);

	return c.json({ token }, 202);
};

export default Login;
