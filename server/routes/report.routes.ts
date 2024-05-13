import { Hono } from 'hono';
import CreateReport from '../controllers/reports/createReport';

const report = new Hono({ strict: false });

report.post('/create', CreateReport);

export default report;
