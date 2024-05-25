module.exports = {
  resolve: {
    extensions: ['.mjs', '.js', '.vue'],
  },
  module: {
    rules: [
      {
        test: /\.mjs$/,
        include: /node_modules/, 
        type: 'javascript/auto', 
      },
      {
        test: /\.vue(\.erb)?$/,
        loader: 'vue-loader'
      },
      {
        test: /\.js$/,
        loader: 'babel-loader',
      },
      {
        test: /\.css$/,
        use: [
          'vue-style-loader',
          'css-loader',
        ],
      },
    ],
  },
};