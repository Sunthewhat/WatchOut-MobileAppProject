import { Context } from 'hono';
import DecodeToken from '../../services/auth/decodeToken';
import CreateReportService from '../../services/report/createReport';
import UploadImageService from '../../services/image/uploadImage';

const CreateReport = async (c: Context) => {
	const st = new Date().getTime();
	try {
		const body = await c.req.parseBody();
		const file = body['file'];
		const token = body['token'].toString();
		const title = body['title'].toString();
		const description = body['description'].toString();
		const type = body['type'].toString();
		const latitude = body['latitude'].toString();
		const longitude = body['longitude'].toString();
		const date = body['date'].toString();

		if (
			!file ||
			!token ||
			!title ||
			!description ||
			!type ||
			!latitude ||
			!longitude ||
			!date
		)
			throw 'Missing required fields';

		const key = await UploadImageService(file as File, 'report');
		const userId = await DecodeToken(token.toString());
		const report = await CreateReportService(
			title,
			description,
			type,
			Number(latitude),
			Number(longitude),
			key.imageId,
			userId,
			date
		);
		const en = new Date().getTime();
		console.log(`${en - st} ms to Create Report`);
		return c.json(
			{
				success: true,
				payload: report,
				message: 'Report created successfully',
			},
			200
		);
	} catch (e) {
		const en = new Date().getTime();
		console.log(`${en - st} ms to Create Report`);
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
