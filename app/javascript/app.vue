<template>
  <div id="app">
    <FlashMessage></FlashMessage>
    <router-view></router-view>
  </div>
</template>

<style lang="scss">
@media (max-width: 768px) {
  .wrapper {
    .top_wrapper {
      background-image: url("./images/IMG_20180505.jpg");
    }
  }
}
@media (min-width: 769px) {
  .wrapper {
    .top_wrapper {
      background-image: url("./images/IMG_20180505_123036.jpg");
    }
  }
}
</style>