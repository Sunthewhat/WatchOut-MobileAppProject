import { PrismaClient } from '@prisma/client';

const IsUsernameExist = async (username: string): Promise<boolean> => {
	const prisma = new PrismaClient();
	const user = await prisma.user.findFirst({
		where: { username },
	});

	return user !== null ? true : false;
};

export default IsUsernameExist;
