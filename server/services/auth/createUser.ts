import { prisma } from '../../index';

const CreateUser = async (
	firstname: string,
	lastname: string,
	username: string,
	password: string
) => {
	const user = await prisma.user.create({
		data: {
			name: firstname + ' ' + lastname,
			username,
			password,
		},
	});
	return user;
};

export default CreateUser;
