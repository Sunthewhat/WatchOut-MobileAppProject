const GetPresignedURL = async () => {
	const presignedAPI = Bun.env.AWS_PRESIGNED_URL!;

	const response = await fetch(presignedAPI);

	return await response.json();
};

export default GetPresignedURL;
