const path = require("path");
module.exports = {
    entry: './assets/scripts/index.ts',
    output: {
        filename: 'index.js',
        path: path.resolve(__dirname, 'src')
    },
    resolve: {
        extensions: [".ts"]
    },
    module: {
        rules: [
            { test: /\.tsx?$/, loader: "ts-loader" }
        ]
    },
    mode: "development",
    devtool: "source-map",
    watch: false
}