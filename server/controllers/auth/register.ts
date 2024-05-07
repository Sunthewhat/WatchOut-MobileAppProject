import { compareSync, genSalt, hash } from 'bcrypt';
import { Context } from 'hono';
import CreateUser from '../../services/auth/createUser';
import IsUsernameExist from '../../services/auth/checkUsername';

const register = async (c: Context) => {
	const { firstname, lastname, username, password } = await c.req.json();

	if (!firstname || !lastname || !username || !password) {
		return c.json({ message: 'Missing required fields' }, 400);
	}

	if (await IsUsernameExist(username)) {
		return c.json({ message: 'Username already exists' }, 401);
	}

	if (!Bun.env.AUTH_SALT) throw new Error('No auth salt found in .env');
	const authSalt: number = parseInt(Bun.env.AUTH_SALT);

	const salt = await genSalt(authSalt);
	const hashedPassword = await hash(password, salt);

	try {
		await CreateUser(firstname, lastname, username, hashedPassword);
	} catch (err) {
		return c.json({ message: 'Failed to register user' }, 500);
	}

	return c.json('User registered successfully!', 201);
};

export default register;
