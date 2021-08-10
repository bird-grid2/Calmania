<template>
  <div id="app">
    <FlashMessage />
    <router-view :key="$route.fullPath" />
  </div>
</template>
