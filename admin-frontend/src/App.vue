<template>
  <div class="layout">
    <aside class="sider">
      <el-menu router default-active="/demo/orders">
        <el-sub-menu index="demo">
          <template #title>Demo</template>
          <el-menu-item index="/demo/orders">订单演示</el-menu-item>
          <el-menu-item index="/demo/jobs">任务索引</el-menu-item>
        </el-sub-menu>
      </el-menu>
    </aside>
    <main class="main"><router-view/></main>
  </div>
</template>
<style>
.layout{display:flex;height:100vh}
.sider{width:220px;border-right:1px solid #eee;padding:6px 0}
.main{flex:1;padding:16px;overflow:auto}
</style>
