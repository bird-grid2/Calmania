module.exports = [
  {
    test: /\.vue$/,
    use: 'vue-loader'
  },
  {
    test: /\.m?js$/,
    include: /node_modules/,
    type: 'javascript/auto'
  },
  {
    test: /\.js$/,
    exclude: /node_modules/,
    use: {
      loader: 'babel-loader',
      options: {
        presets: ['@babel/preset-env']
      }
    }
  }
];
