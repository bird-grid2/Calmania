const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const commonLoaders = require('./loaders/common')
const postCssConfig = require('../../postcss.config.js')

// vue-loaderのオプションを読み込み
commonLoaders.forEach(loaders => {
  environment.loaders.prepend(loaders.test.toString(), loaders)
})

// `.mjs` ファイルを自動的に解決するために拡張子を追加
environment.config.merge({
  resolve: {
    extensions: ['.js', '.mjs']
  }
})

// dart-sassの設定読み込み
environment.loaders.append('sass', {
  test: /\.scss$/,
  exclude: /node_modules/,
  use: [
    'style-loader',
    'css-loader',
    {
      loader: 'postcss-loader',
      options: {
        postCssConfig
      }
    },
    {
      loader: 'sass-loader',
      options: {
        implementation: require('sass')
      }
    }
  ]
});

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
module.exports = environment
