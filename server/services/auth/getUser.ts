import { prisma } from '../../index';

const GetUser = (username: string) => {
	return prisma.users.findFirst({
		where: { username },
	});
};

export default GetUser;
