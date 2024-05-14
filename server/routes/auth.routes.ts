import { Hono } from 'hono';
import Login from '../controllers/auth/login';
import Register from '../controllers/auth/register';
import Verify from '../controllers/auth/verify';
import GetUser from '../controllers/auth/getUser';

const auth = new Hono({ strict: false });

auth.post('/login', Login);
auth.post('/register', Register);
auth.post('/verify', Verify);
auth.get('/user', GetUser);

export default auth;
