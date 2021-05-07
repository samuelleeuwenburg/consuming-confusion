const path = require('path')

module.exports = [
		{
				entry: path.resolve(__dirname, 'src/Client.bs.js'),
				output: {
						path: path.resolve(__dirname, 'static'),
						filename: 'bundle.js',
				},
				devtool: 'source-map',
		},
		{
				entry: path.resolve(__dirname, 'src/Server.bs.js'),
				output: {
						path: path.resolve(__dirname, 'dist'),
						filename: 'server.js',
				},
				target: 'node',
		}
]
