const ValidateENV = () => {
	if (Bun.env.ENV_VALIDATION != 'true') {
		throw new Error('No .env file found');
	}
};

export default ValidateENV;
