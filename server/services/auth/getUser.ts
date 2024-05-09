import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

const GetUser = (username: string) => {
	return prisma.user.findFirst({
		where: { username },
	});
};

export default GetUser;
