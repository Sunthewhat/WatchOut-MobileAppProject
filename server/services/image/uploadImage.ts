import ConvertToPNG from './convertToPNG';
import GetPresignedURL from './getPresignedURL';
import StoreImageKey from './storeImageKey';
import UploadToS3 from './uploadByPresignedURL';

const UploadImageService = async (rawImg: File, type: string) => {
	if (!rawImg) throw new Error('No Image File Found!');
	const image = await ConvertToPNG(rawImg);
	const { presignedUrl, key } = await GetPresignedURL();
	await UploadToS3(presignedUrl, image);
	const imageId = await StoreImageKey(key, type);
	const keyString = key as string;
	return { key: keyString, imageId };
};

export default UploadImageService;
