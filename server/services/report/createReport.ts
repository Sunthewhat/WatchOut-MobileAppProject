import { prisma } from '../../index';

const CreateReportService = async (
	title: string,
	description: string,
	type: string,
	latitude: number,
	longitude: number,
	imageId: number,
	userId: number,
	date: string
) => {
	const report = await prisma.reports.create({
		data: {
			title: title,
			description: description,
			type: type,
			latitude: latitude,
			longitude: longitude,
			time: new Date(date),
			imageId: imageId,
			userId: userId,
		},
	});
	return report;
};

export default CreateReportService;
