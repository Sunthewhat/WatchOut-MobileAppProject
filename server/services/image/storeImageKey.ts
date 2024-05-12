import { prisma } from '../../index';

const StoreImageKey = async (key: string, type: string) => {
	const res = await prisma.images.create({
		data: {
			key,
			type,
		},
	});
	return res.id;
};

export default StoreImageKey;
