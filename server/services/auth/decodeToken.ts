import { JwtPayload, verify } from 'jsonwebtoken';

const DecodeToken = async (token: string) => {
	const decoded: JwtPayload = verify(
		token,
		process.env.JWT_SECRET!
	) as JwtPayload;
	const { id } = decoded;
	return id as number;
};

export default DecodeToken;
