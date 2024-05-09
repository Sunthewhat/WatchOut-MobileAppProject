import { prisma } from '../../index';

const GetUser = (username: string) => {
	return prisma.user.findFirst({
		where: { username },
	});
};

export default GetUser;
