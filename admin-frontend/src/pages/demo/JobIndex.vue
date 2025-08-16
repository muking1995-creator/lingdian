<template>
  <div>
    <div class="toolbar">
      <el-input v-model="form.partner" placeholder="partner" style="width:160px"/>
      <el-input v-model="form.type" placeholder="type" style="width:160px"/>
      <el-select v-model="form.status" placeholder="status" style="width:140px" clearable>
        <el-option label="queued" value="queued"/><el-option label="done" value="done"/><el-option label="failed" value="failed"/>
      </el-select>
      <el-button type="primary" @click="load">查询</el-button>
    </div>
    <el-table :data="list" height="calc(100vh - 240px)" border>
      <el-table-column prop="id" label="ID" width="80"/>
      <el-table-column prop="job_id" label="JobID" width="260"/>
      <el-table-column prop="partner" label="Partner" width="140"/>
      <el-table-column prop="type" label="Type" width="160"/>
      <el-table-column prop="status" label="状态" width="120"/>
      <el-table-column prop="attempts" label="尝试" width="100"/>
      <el-table-column prop="last_error" label="最后错误"/>
      <el-table-column prop="created_at" label="创建时间" width="180"/>
    </el-table>
    <div class="pager">
      <el-pagination background layout="prev, pager, next"
        :total="total" :page-size="perPage" @current-change="pageChange"/>
    </div>
  </div>
</template>
<script setup>
import { ref } from 'vue'
import axios from '../../utils/http'
const list = ref([]); const total = ref(0); const page = ref(1); const perPage = ref(20)
const form = ref({ partner:'', type:'', status:'' })
async function load(){ const { data } = await axios.get('/admin/jobs/index', { params:{ page: page.value, per_page: perPage.value, ...form.value } }); list.value=data.data; total.value=data.total }
function pageChange(p){ page.value=p; load() }
load()
</script>
<style scoped>
.toolbar{display:flex;gap:8px;margin-bottom:12px;align-items:center;flex-wrap:wrap}
.pager{text-align:right;margin-top:10px}
</style>
