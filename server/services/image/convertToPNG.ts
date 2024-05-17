import Sharp = require('sharp');

const ConvertToPNG = async (raw: File) => {
	const rawArrBuffer = await raw.arrayBuffer();
	const rawBuffer = Buffer.from(rawArrBuffer);
	const pngBuffer = await Sharp(rawBuffer)
		.png({ quality: 30 })
		// .rotate(90)
		.toBuffer();
	const pngFile = new File([pngBuffer], raw.name, { type: 'image/png' });
	return pngFile;
};

export default ConvertToPNG;
