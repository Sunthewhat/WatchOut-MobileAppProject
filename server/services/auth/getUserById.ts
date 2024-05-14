import { prisma } from '../..';

const GetUserById = async (id: number) => {
	const response = await prisma.users.findMany({
		where: { id },
		include: {
			Images: {
				select: {
					key: true,
				},
			},
		},
	});
	return {
		name: response[0].name,
		image: Bun.env.AWS_BUCKET_GET_URL! + response[0].Images.key,
	};
};

export default GetUserById;
