<template>
  <div class='wrapper'>
    <div class='side-management'>
      <div class='container' id='target'>  
        <router-link class='inner' id='target_2' to='/sign_in'>#</router-link> 
      </div>
    </div>
    <div class='top_wrapper'>
      <div class='top_wrapper__header pc'>
        Let's Enjoy Calory controlling<br>
        <br>To ideal yourself ...
      </div> 
      <div class='top_wrapper__content pc'>
        <h1>
          <span class='char1'>C</span>
          <span class='char2'>a</span>
          <span class='char3'>l</span>
          <span class='char4'>m</span>
          <span class='char5'>a</span>
          <span class='char6'>n</span>
          <span class='char7'>i</span>
          <span class='char8'>a</span>
        </h1>
      </div>
      <div class='top_wrapper__header sp'>
        Calmania
      </div>
      <div class='top_wrapper__content sp'>
        Let's Enjoy Calory controlling <br>
        <br>To ideal yourself ...
      </div>
    </div>
  </div>
</template>

<style lang="scss">
@media (max-width: 768px) {
  .wrapper {
    .top_wrapper {
      background-image: url("../images/IMG_20180505.jpg");
    }
  }
}
@media (min-width: 769px) {
  .wrapper {
    .top_wrapper {
      background-image: url("../images/IMG_20180505_123036.jpg");
    }
  }
}
</style>