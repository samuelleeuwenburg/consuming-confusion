const path = require('path')

module.exports = {
		entry: path.resolve(__dirname, 'src/client.bs.js'),
		output: {
				path: path.resolve(__dirname, 'static'),
				filename: 'bundle.js',
		},
		devtool: 'source-map',
}
