import { Hono } from 'hono';
import Login from '../controllers/auth/login';
import register from '../controllers/auth/register';
import UsernameAvailability from '../controllers/auth/usernameAvailability';

const auth = new Hono({ strict: false });

auth.post('/login', Login);
auth.post('/register', register);
auth.get('/username/:username', UsernameAvailability);

export default auth;
