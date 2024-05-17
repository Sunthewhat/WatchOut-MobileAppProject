import { prisma } from '../../index';

const GetAllReportService = async () => {
	const response = await prisma.reports.findMany({
		include: {
			images: {
				select: {
					key: true,
				},
			},
			User: {
				select: {
					name: true,
					Images: {
						select: {
							key: true,
						},
					},
				},
			},
		},
		orderBy: {
			time: 'desc',
		},
	});
	const AWSGetKey = Bun.env.AWS_BUCKET_GET_URL!;
	const reports = response.map((report) => {
		return {
			id: report.id,
			title: report.title,
			description: report.description,
			image: AWSGetKey + report.images.key,
			type: report.type,
			time: report.time,
			latitude: report.latitude,
			longitude: report.longitude,
			user: report.User.name,
			userImage: report.User.Images
				? AWSGetKey + report.User.Images.key
				: '',
		};
	});
	return reports;
};

export default GetAllReportService;
