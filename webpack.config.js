const path = require("path");

module.exports = {
  entry: path.resolve(__dirname, "src/Client.bs.js"),
  output: {
    path: path.resolve(__dirname, "static"),
    filename: "bundle.js",
  },
  devtool: "source-map",
};
