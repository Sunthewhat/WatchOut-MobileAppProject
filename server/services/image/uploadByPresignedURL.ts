const UploadToS3 = async (presignedUrl: string, file: File) => {
	const uploadResponse = await fetch(presignedUrl, {
		method: 'PUT',
		body: file,
		headers: {
			'Content-Type': 'image/png',
		},
	});
	return uploadResponse + '';
};

export default UploadToS3;
