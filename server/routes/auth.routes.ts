import { Hono } from 'hono';
import Login from '../controllers/auth/login';
import Register from '../controllers/auth/register';
import Verify from '../controllers/auth/verify';

const auth = new Hono({ strict: false });

auth.post('/login', Login);
auth.post('/register', Register);
auth.post('/verify', Verify);

export default auth;
