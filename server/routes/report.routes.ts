import { Hono } from 'hono';
import CreateReport from '../controllers/reports/createReport';
import GetAllReport from '../controllers/reports/getAllReport';

const report = new Hono({ strict: false });

report.post('/create', CreateReport);
report.get('/', GetAllReport);

export default report;
