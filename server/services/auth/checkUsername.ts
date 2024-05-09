import { prisma } from '../../index';

const IsUsernameExist = async (username: string): Promise<boolean> => {
	const user = await prisma.user.findFirst({
		where: { username },
	});

	return user !== null ? true : false;
};

export default IsUsernameExist;
