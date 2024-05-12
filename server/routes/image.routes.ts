import { Hono } from 'hono';
import Upload from '../controllers/image/upload';

const image = new Hono({ strict: false });

image.put('/upload', Upload);

export default image;
