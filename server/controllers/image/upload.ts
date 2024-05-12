import { Context } from 'hono';
import UploadImageService from '../../services/image/uploadImage';

const Upload = async (c: Context) => {
	try {
		const body = await c.req.parseBody();
		const raw = body['file'];
		const key = await UploadImageService(raw as File, 'upload');
		return c.json({
			success: true,
			payload: {
				key,
			},
			message: 'File uploaded successfully',
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

export default Upload;
