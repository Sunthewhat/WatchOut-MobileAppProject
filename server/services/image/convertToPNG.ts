import Sharp = require('sharp');

const ConvertToPNG = async (raw: File) => {
	const st = new Date().getTime();
	const rawArrBuffer = await raw.arrayBuffer();
	const rawBuffer = Buffer.from(rawArrBuffer);
	const pngBuffer = await Sharp(rawBuffer)
		.png({ quality: 20 })
		// .rotate(90)
		.toBuffer();
	const pngFile = new File([pngBuffer], raw.name, { type: 'image/png' });
	const en = new Date().getTime();
	console.log(`${en - st} ms Converting and Resizing to PNG`);
	return pngFile;
};

export default ConvertToPNG;
