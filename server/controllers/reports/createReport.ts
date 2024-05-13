import { Context } from 'hono';
import { PrismaClient } from '../../prisma/client';
import DecodeToken from '../../services/auth/decodeToken';

const CreateReport = async (c: Context) => {
	try {
		const {
			token,
			imageId,
			title,
			description,
			type,
			latitude,
			longitude,
		} = await c.req.json();
		const prisma = new PrismaClient();
		const userId = await DecodeToken(token);
		const report = await prisma.reports.create({
			data: {
				title: title,
				description: description,
				type: type,
				latitude: latitude,
				longitude: longitude,
				time: new Date(),
				imageId: imageId,
				userId: userId,
			},
		});
		return c.json({
			success: true,
			payload: {
				report,
			},
			message: 'Report created successfully',
		});
	} catch (e) {
		console.error(e);
		return c.json({
			success: false,
			payload: null,
			message: e,
		});
	}
};

export default CreateReport;
