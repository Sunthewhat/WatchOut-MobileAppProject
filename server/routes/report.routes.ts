import { Hono } from 'hono';
import CreateReport from '../controllers/reports/createReport';
import GetAllReport from '../controllers/reports/getAllReport';
import GetReportByUser from '../controllers/reports/getReportByUser';

const report = new Hono({ strict: false });

report.post('/create', CreateReport);
report.get('/', GetAllReport);
report.get('/user', GetReportByUser);

export default report;
