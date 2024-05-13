import { prisma } from '../../index';

const GetAllReportService = async () => {
	const reports = await prisma.reports.findMany();
	return reports;
};

export default GetAllReportService;
