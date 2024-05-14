import { Context } from 'hono';
import DecodeToken from '../../services/auth/decodeToken';
import CreateReportService from '../../services/report/createReport';

const CreateReport = async (c: Context) => {
	try {
		const {
			token,
			imageId,
			title,
			description,
			type,
			latitude,
			longitude,
		} = await c.req.json();
		const userId = await DecodeToken(token);
		const report = await CreateReportService(
			title,
			description,
			type,
			latitude,
			longitude,
			imageId,
			userId
		);
		return c.json(
			{
				success: true,
				payload: report,
				message: 'Report created successfully',
			},
			200
		);
	} catch (e) {
		console.error(e);
		return c.json(
			{
				success: false,
				payload: {
					id: 0,
					imageId: 0,
					userId: 0,
					title: '',
					description: '',
					type: '',
					time: new Date(),
					latitude: 0,
					longitude: 0,
				},
				message: e,
			},
			200
		);
	}
};

export default CreateReport;
