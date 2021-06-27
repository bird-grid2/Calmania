<template>
  <div class='wrapper'>
    <div class='side-management'>
      <router-link to='/management'>
        <i class='fas fa-home'></i>
        <h6 class='pc'>Home</h6>
        <h6 class='sp'>Home</h6>
      </router-link>
      <router-link to='/'>
        <i class='fas fa-sign-out-alt'></i>
        <h6 class='pc'>Sign<br>out</h6>
        <h6 class='sp'>Sign out</h6>
      </router-link>
    </div>
    <div class='graph_wrapper'>
      <div class='graph_upper'>
        <div class='left_graph'>
          {{ `<img src="/assets/test_${gon.userId}_1.png">` }}
        </div>
        <div class="right_graph">
          {{ `<img src="/assets/test_${gon.userId}_2.png">` }}
        </div>
      </div>
      <div class='graph_bottom'>
        <div class='left_graph'>
          {{ `<img src="/assets/test_${gon.userId}_3.png">` }}
        </div>
        <div class='right_graph'>
          {{ `<img src="/assets/test_${gon.userId}_4.png">` }}
        </div>
      </div>
    </div>
  </div>
</template>
