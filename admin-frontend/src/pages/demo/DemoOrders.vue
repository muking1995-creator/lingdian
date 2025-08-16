<template>
  <div>
    <el-card class="mb">
      <template #header>下单演示</template>
      <el-form :inline="true" :model="form">
        <el-form-item label="交易对"><el-input v-model="form.symbol" placeholder="BTC/USDT"/></el-form-item>
        <el-form-item label="方向">
          <el-select v-model="form.side" style="width:120px">
            <el-option label="买" value="buy"/><el-option label="卖" value="sell"/>
          </el-select>
        </el-form-item>
        <el-form-item label="数量"><el-input-number v-model="form.amount" :min="0" :step="1"/></el-form-item>
        <el-form-item label="价格"><el-input-number v-model="form.price" :min="0" :step="0.01"/></el-form-item>
        <el-form-item><el-button type="primary" @click="place">创建订单</el-button></el-form-item>
      </el-form>
    </el-card>

    <el-table :data="list" height="calc(100vh - 380px)" border>
      <el-table-column prop="id" label="ID" width="80"/>
      <el-table-column prop="partner" label="渠道" width="120"/>
      <el-table-column prop="symbol" label="交易对" width="140"/>
      <el-table-column prop="side" label="方向" width="100"/>
      <el-table-column prop="amount" label="数量" width="120"/>
      <el-table-column prop="price" label="价格" width="120"/>
      <el-table-column prop="status" label="状态" width="120"/>
      <el-table-column prop="created_at" label="创建时间" width="180"/>
      <el-table-column label="操作" width="200">
        <template #default="{row}">
          <el-button size="small" @click="query(row.id)">主动查询</el-button>
        </template>
      </el-table-column>
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
import { ElMessage } from 'element-plus'
const form = ref({ symbol:'BTC/USDT', side:'buy', amount:1, price:100 })
const list = ref([]); const total = ref(0); const page = ref(1); const perPage = ref(15)
async function load(){ const { data } = await axios.get('/admin/demo/orders', { params:{ page: page.value, per_page: perPage.value } }); list.value=data.data; total.value=data.total }
async function place(){ const { data } = await axios.post('/admin/demo/orders', form.value); ElMessage.success('已创建，job='+data.data.job_id); load() }
async function query(id){ await axios.post(`/admin/demo/orders/${id}/query`); ElMessage.success('已触发查询'); }
function pageChange(p){ page.value=p; load() }
load()
</script>
<style scoped>
.mb{ margin-bottom:12px }
.pager{text-align:right;margin-top:10px}
</style>
