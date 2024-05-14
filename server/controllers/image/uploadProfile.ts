import { Context } from 'hono';
import UploadImageService from '../../services/image/uploadImage';
import DecodeToken from '../../services/auth/decodeToken';
import ChangeProfileImg from '../../services/image/changeProfileImg';

const UploadProflieImg = async (c: Context) => {
	try {
		const body = await c.req.parseBody();
		const raw = body['file'];
		const token = body['token'];
		const key = await UploadImageService(raw as File, 'profile');
		const userId = await DecodeToken(token as string);
		await ChangeProfileImg(userId, key.imageId);
		return c.json({
			success: true,
			payload: null,
			message: 'Profile image uploaded successfully',
		});
	} catch (error) {
		console.error(error);
		return c.json({
			success: false,
			payload: null,
			message: error || 'An error occurred',
		});
	}
};

export default UploadProflieImg;
