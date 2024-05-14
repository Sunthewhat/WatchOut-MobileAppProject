import { prisma } from '../..';

const ChangeProfileImg = async (userId: number, imageId: number) => {
	const user = await prisma.users.update({
		where: { id: userId },
		data: {
			imageId: imageId,
		},
	});
	return user;
};

export default ChangeProfileImg;
