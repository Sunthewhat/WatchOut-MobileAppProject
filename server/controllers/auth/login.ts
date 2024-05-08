import { Context } from 'hono';
import { compareSync } from 'bcrypt';
import GetUser from '../../services/auth/getUser';
import * as jwt from 'jsonwebtoken';

const Login = async (c: Context) => {
	const { username, password } = await c.req.json();
	if (!username || !password) {
		return c.json(
			{
				success: false,
				payload: {
					code: 1,
					token: null,
				},
				message: 'Missing required fields',
			},
			200
		);
	}
	const user = await GetUser(username);
	if (!user)
		return c.json(
			{
				success: false,
				payload: {
					code: 2,
					token: null,
				},
				message: 'User not found',
			},
			200
		);
	if (!compareSync(password, user.password))
		return c.json(
			{
				success: false,
				payload: {
					code: 3,
					token: null,
				},
				message: 'Incorrect password',
			},
			200
		);

	const secret = Bun.env.JWT_SECRET;
	if (!secret) throw new Error('No JWT secret found in .env');
	const token = jwt.sign({ id: user.id }, secret);

	return c.json(
		{
			success: true,
			payload: {
				code: 0,
				token,
			},
			message: 'User logged in successfully',
		},
		200
	);
};

export default Login;
