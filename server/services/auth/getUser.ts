import { PrismaClient } from '@prisma/client';

const GetUser = (username: string) => {
	const prisma = new PrismaClient();
	return prisma.user.findFirst({
		where: { username },
	});
};

export default GetUser;
