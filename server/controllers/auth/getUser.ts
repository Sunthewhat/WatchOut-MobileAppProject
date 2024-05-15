import { Context } from 'hono';
import GetUserById from '../../services/auth/getUserById';
import DecodeToken from '../../services/auth/decodeToken';

const GetUser = async (c: Context) => {
	try {
		const token = c.req.query('token');

		if (!token)
			return c.json({
				success: false,
				payload: null,
				message: 'Missing required fields',
			});

		const userId = await DecodeToken(token);
		const PublicUserData = await GetUserById(userId);
		return c.json({
			success: true,
			payload: PublicUserData,
			message: 'User fetched',
		});
	} catch (e) {
		console.error(e);
		return c.json({
			success: false,
			payload: null,
			message: e,
		});
	}
};

export default GetUser;
