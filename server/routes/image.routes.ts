import { Hono } from 'hono';
import Upload from '../controllers/image/upload';
import UploadProflieImg from '../controllers/image/uploadProfile';

const image = new Hono({ strict: false });

image.put('/upload', Upload);
image.put('/profile', UploadProflieImg);

export default image;
