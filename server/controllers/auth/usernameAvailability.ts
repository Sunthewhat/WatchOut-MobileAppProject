import { Context } from 'hono';
import IsUsernameExist from '../../services/auth/checkUsername';

const UsernameAvailability = async (c: Context) => {
	const { username } = c.req.param();
	if (!username) return c.json({ message: 'Missing username' }, 400);
	const isAvailable = await IsUsernameExist(username);
	return c.json(!isAvailable);
};

export default UsernameAvailability;
