const UploadToS3 = async (presignedUrl: string, file: File) => {
	const st = new Date().getTime();
	const uploadResponse = await fetch(presignedUrl, {
		method: 'PUT',
		body: file,
		headers: {
			'Content-Type': 'image/png',
		},
	});
	const en = new Date().getTime();
	console.log(`${en - st} ms To upload to S3`);
	return uploadResponse + '';
};

export default UploadToS3;
