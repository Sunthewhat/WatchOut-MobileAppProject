import { Context } from 'hono';
import IsUsernameExist from '../../services/auth/checkUsername';

const UsernameAvailability = async (c: Context) => {
	const { username } = c.req.param();
	if (!username)
		return c.json(
			{
				success: false,
				payload: null,
				message: 'Missing required fields',
			},
			200
		);
	const isAvailable = await IsUsernameExist(username);
	return c.json(
		{
			success: true,
			payload: { isAvailable },
			message: 'Username availability checked',
		},
		200
	);
};

export default UsernameAvailability;
