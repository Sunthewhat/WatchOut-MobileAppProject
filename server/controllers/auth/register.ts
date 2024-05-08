import { compareSync, genSalt, hash } from 'bcrypt';
import { Context } from 'hono';
import CreateUser from '../../services/auth/createUser';
import IsUsernameExist from '../../services/auth/checkUsername';

const register = async (c: Context) => {
	const { firstname, lastname, username, password } = await c.req.json();

	if (!firstname || !lastname || !username || !password) {
		return c.json(
			{
				success: false,
				payload: {
					code: 1,
				},
				message: 'Missing required fields',
			},
			200
		);
	}

	if (await IsUsernameExist(username)) {
		return c.json(
			{
				success: false,
				payload: {
					code: 2,
				},
				message: 'Username already exists',
			},
			200
		);
	}

	if (!Bun.env.AUTH_SALT) throw new Error('No auth salt found in .env');
	const authSalt: number = parseInt(Bun.env.AUTH_SALT);

	const salt = await genSalt(authSalt);
	const hashedPassword = await hash(password, salt);

	try {
		await CreateUser(firstname, lastname, username, hashedPassword);
	} catch (err) {
		return c.json(
			{
				success: false,
				payload: {
					code: 3,
				},
				message: 'Failed to register user',
			},
			200
		);
	}

	return c.json(
		{
			success: true,
			payload: {
				code: 0,
			},
			message: 'User registered successfully',
		},
		200
	);
};

export default register;
