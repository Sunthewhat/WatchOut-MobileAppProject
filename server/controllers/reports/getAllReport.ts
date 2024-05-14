import { Context } from 'hono';
import GetAllReportService from '../../services/report/getAllReport';

const GetAllReport = async (c: Context) => {
	try {
		const reports = await GetAllReportService();
		return c.json(
			{
				success: true,
				payload: reports,
				message: 'Reports fetched successfully',
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

export default GetAllReport;
