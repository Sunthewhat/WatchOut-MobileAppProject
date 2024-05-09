import { S3Client } from '@aws-sdk/client-s3';
import { HonoS3Storage } from '@hono-storage/s3';

const accessKeyId = process.env.AWS_ACCESS_KEY_ID;
const secretAccessKey = process.env.AWS_SECRET_ACCESS_KEY;
const bucket = process.env.AWS_BUCKET_NAME;

if (!accessKeyId || !secretAccessKey) {
	throw new Error('No AWS credentials found in .env');
}

const client = new S3Client({
	region: 'eu-north-1',
	credentials: {
		accessKeyId: accessKeyId,
		secretAccessKey: secretAccessKey,
	},
});

const storage = new HonoS3Storage({
	key: (_, file) =>
		`${file.originalname}-${new Date().getTime()}.${file.extension}`,
	bucket: bucket!,
	client,
});

export default storage;
