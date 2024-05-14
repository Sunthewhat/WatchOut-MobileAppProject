import { Context } from 'hono';
import GetUserReportService from '../../services/report/getReportByUserId';
import DecodeToken from '../../services/auth/decodeToken';

const GetReportByUser = async (c: Context) => {
	try {
		const { token } = c.req.query();
		const userId = await DecodeToken(token);
		const userReports = await GetUserReportService(userId);
		return c.json(
			{
				success: true,
				payload: userReports,
				message: 'User reports fetched successfully',
			},
			200
		);
	} catch (e) {
		console.error(e);
		return c.json(
			{
				success: false,
				payload: [],
				message: e,
			},
			200
		);
	}
};

export default GetReportByUser;
